# Dockerized Flask Web App with MariaDB and Nginx

This project is a minimal full-stack web application with:

- 🔧 **Flask** (served via Gunicorn)
- 🛢️ **MariaDB** (as the database)
- 🌐 **Nginx** (as a reverse proxy and SSL terminator)
- 🐳 **Docker Compose** for orchestration
- 🔐 **.env** file for environment variables

---

## 🧱 Project Structure

```
Dockerized-Flask-Message-Logger-with-IP-Tracking/
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   ├── Dockerfile
│   └── templates/
│       └── form.html
│
├── nginx/
│   ├── nginx.conf
│   └── certs/
│       ├── fullchain.pem
│       └── privkey.pem
│
|── .env
├── docker-compose.yml
└── README.md

```
# Arch Overview 
     +------------+
     |   Client   |
     +------------+
           |
     HTTPS | TLS (443)
           ↓
    +-------------+
    |   Nginx     | ← handles HTTPS & reverse proxy
    +-------------+
           |
      HTTP | (5000)
           ↓
    +-------------+
    |  Flask App  | ← Gunicorn + .env
    +-------------+
           |
     TCP 3306
           ↓
    +-------------+
    |  MariaDB    |
    +-------------+

---

## 🔐 Environment Variables (.env)

We use a `.env` file to securely pass sensitive information (like database credentials) into Docker containers.

### ✅ Example `.env` file:

```
# Database settings
DB_HOST=db
DB_NAME=mydatabase
DB_USER=myuser
DB_PASSWORD=securepassword
```

> ⚠️ **Never commit `.env` to GitHub**. Add `.env` to your `.gitignore`.

### 🔧 In `docker-compose.yml`

Docker Compose loads this `.env` file automatically.

```yaml
services:
  flask_webapp:
    env_file:
      - .env
```

### 🔧 In Flask app (`app.py`)

Python uses the `os` module to read environment variables:

```python
import os
import pymysql

db = pymysql.connect(
    host=os.getenv("DB_HOST", "localhost"),
    user=os.getenv("DB_USER", "user"),
    password=os.getenv("DB_PASSWORD", "pass"),
    database=os.getenv("DB_NAME", "mydb"),
    connect_timeout=5
)
```

---

## ✅ NGINX Features

- 📝 Submit messages through a form
- 🌐 Log real client IPs (`X-Real-IP`)
- 🛡️ HTTPS support via Nginx with self-signed certs (for dev)
- 🐳 Fully containerized (Flask + Nginx + MariaDB)

---

## 📦 Services Used (via `docker-compose`)

| Service     | Role                         | Port |
|-------------|------------------------------|------|
| `nginx`     | Reverse Proxy + SSL/TLS      | 80 / 443 |
| `flask_webapp` | Flask Python app          | 5000 (internal) |
| `db`        | MariaDB database              | 3306 |

---

## 🚀 Web APP Features (This WEBAPP is just For Testing)

- Flask frontend with a single input form.
- Logs each message and IP address using Python's `logging`.
- Stores messages in MySQL database.
- Tracks user IP addresses.
- Fully containerized using Docker Compose.

---

## 🐳 How to Run (Docker Compose)

```bash
# Step 1: Clone the repo
git clone https://github.com/senani-derradji/Dockerized-Flask-Message-Logger-with-IP-Tracking.git
cd Dockerized-Flask-Message-Logger-with-IP-Tracking

# Step 2: Build and start the containers
docker-compose up --build &
```

Access the app at: [https://derradji.com](derradji.com)

---

## 🧪 Test the App

1. Open your browser and go to `derradji.com`
2. Enter a message in the form.
3. Submit it — your message and IP will be saved to the DB.
4. wrk -t4 -c100 -d30s https://derradji.com

---


## 🗃️ MariaDB Configuration

The MariaDB service is defined inside `docker-compose.yml`:

- **Host:** `db`
- **User:** `derradji`
- **Password:** `PASS1212`
- **Database:** `crudsdb`

---
