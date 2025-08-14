from flask import Flask, render_template, request, redirect, session, url_for
import pymysql, redis, os
from prometheus_flask_exporter import PrometheusMetrics


app = Flask(__name__)
app.secret_key = os.getenv("SECRET_KEY", "mysecret")

metrics = PrometheusMetrics(app)

# Load DB credentials from env
DB_HOST = os.getenv("DB_HOST", "db")
DB_USER = os.getenv("DB_USER", "usr")
DB_PASSWORD = os.getenv("DB_PASSWORD", "pass")
DB_NAME = os.getenv("DB_NAME", "db")

# Step 1: Connect to MySQL without specifying database
conn = pymysql.connect(
    host=DB_HOST,
    user=DB_USER,
    password=DB_PASSWORD,
    connect_timeout=5
)

# Step 2: Create the database if it doesn't exist
with conn.cursor() as cursor:
    cursor.execute(f"CREATE DATABASE IF NOT EXISTS `{DB_NAME}`")
conn.commit()
conn.close()

# Step 3: Reconnect, now with database
db = pymysql.connect(
    host=DB_HOST,
    user=DB_USER,
    password=DB_PASSWORD,
    database=DB_NAME,
    connect_timeout=5
)

# Redis Configuration
redis_host = os.getenv("REDIS_HOST", "localhost")
redis_port = int(os.getenv("REDIS_PORT", 6379))
redis_password = os.getenv("REDIS_PASSWORD", None)

redis_client = redis.Redis(
    host=redis_host,
    port=redis_port,
    password=redis_password,
    decode_responses=True
)

# Step 4: Create users table if not exists
with db.cursor() as cursor:
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            username VARCHAR(100) UNIQUE,
            password VARCHAR(100)
        )
    """)
    db.commit()

# Routes...

@app.route("/")
def index():
    if "username" in session:
        return f"<h2>Welcome, {session['username']}!</h2><a href='/logout'>Logout</a>"
    return redirect("/login")

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        with db.cursor() as cursor:
            try:
                cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, password))
                db.commit()
                return redirect("/login")
            except pymysql.err.IntegrityError:
                return "Username already exists."
    return render_template("register.html")

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        # Redis cache check
        cached = redis_client.get(f"user:{username}")
        if cached and cached == password:
            session["username"] = username
            return redirect("/")
        with db.cursor() as cursor:
            cursor.execute("SELECT * FROM users WHERE username=%s AND password=%s", (username, password))
            user = cursor.fetchone()
        if user:
            redis_client.set(f"user:{username}", password)
            session["username"] = username
            return redirect("/")
        else:
            return "Invalid credentials."
    return render_template("login.html")

@app.route("/logout")
def logout():
    session.clear()
    return redirect("/login")

# if __name__ == "__main__":
#     app.run(host="0.0.0.0", port=5000, debug=True)
