# This is a simple Flask application that connects to a MySQL database using pymysql.
# You Can use your WebApp here and replace the code below with your WebApp code.

from flask import Flask, request, render_template, redirect
import pymysql, os

app = Flask(__name__)

try:
    db = pymysql.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER", "user"),
        password=os.getenv("DB_PASSWORD", "password"),
        database=os.getenv("DB_NAME", "name"),
        connect_timeout=5 )
    print("Connected to the database successfully.")

except pymysql.MySQLError as e:
    print(f"Error connecting to the database: {e}")
    db = None

if db is None:
    print("Database connection failed. Exiting the application.")
    exit(1)

# Create the messages table if it doesn't exist
with db.cursor() as cursor:
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS messages (
            id INT AUTO_INCREMENT PRIMARY KEY,
            ip_address VARCHAR(100),
            message TEXT
        )
    """)
    db.commit()


@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        msg = request.form['message']
        ip = request.remote_addr

        with db.cursor() as cursor:
            cursor.execute("INSERT INTO messages (ip_address, message) VALUES (%s, %s)", (ip, msg))
            db.commit()
        return f"<h2>Your message: {msg}</h2><br><a href='/'>Back</a>"

    return render_template('form.html')


@app.route("/app", methods=["GET"])
def app_page():
    return "<h1> APP PAGE 200:OK </h1>"
