# Dockerized Flask Message Logger with IP Tracking

A lightweight Flask web application that allows users to submit a message through a simple web interface. Each submitted message is:

- Saved to a MySQL database along with the user's IP address.
- Logged using Python's `logging` module.
- Deployed using Docker and Docker Compose.

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
    |  Flask App  | ← logs message + IP
    +-------------+
           |
     TCP 3306
           ↓
    +-------------+
    |  MariaDB    |
    +-------------+

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

---


## 🗃️ MariaDB Configuration

The MariaDB service is defined inside `docker-compose.yml`:

- **Host:** `db`
- **User:** `derradji`
- **Password:** `PASS1212`
- **Database:** `crudsdb`

---
