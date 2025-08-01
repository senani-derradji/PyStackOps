# 🚀 Dockerized Python Backend WebApp (Flask/Gunicorn + MariaDB + Redis + Nginx)

A production-ready Python web application backend built with:

- ⚙️ **Flask** served by **Gunicorn**
- 🗃️ **MariaDB** for user authentication and data storage
- ⚡ **Redis** for caching
- 🌐 **Nginx** as reverse proxy + HTTPS + caching layer
- 🐳 **Docker Compose** for orchestration
- 🔐 **Environment Variables** via `.env` file
- 🧠 **Login / Register** flow with persistent user data

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
│       ├── register.html
│       └── login.html
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

<img width="1024" height="1536" alt="a03e8c15-9bf9-470a-81da-b290d79f4e77" src="https://ik.imagekit.io/emfhb8pe6/ChatGPT%20Image%20Aug%202,%202025,%2012_50_06%20AM.png" />

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

---

## 📦 Services Used (via `docker-compose`)

| Service     | Role                         | Port |
|-------------|------------------------------|------|
| `nginx`     | Reverse Proxy + SSL/TLS + cache     | 80 / 443 |
| `flask_webapp` | Flask Python app          | 5000 (internal) |
| `db`        | MariaDB database              | 3306 |
| `redis`        | In-memory caching         | 6379        |
| `portainer`    | Docker GUI (optional)     | 9000        |

---

## 🔑 Auth Features

- ✅ **User registration** with username + password
- ✅ **Secure login**
- ✅ Stores user data in **MariaDB**
- ✅ Uses **Redis** to cache pages or queries
- ✅ Protects routes and sessions with Flask `secret_key`


---

## 🐳 How to Run (Docker Compose)

```bash
# Step 1: Clone the repo
git clone https://github.com/senani-derradji/Python-Dockerized-Backend.git
cd Python-Dockerized-Backend

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

## 🧰 Portainer Integration

This project includes **Portainer** for visual Docker management.

Portainer provides a web-based GUI to manage your Docker environment easily.  
It helps monitor containers, networks, volumes, images, and more — directly from the browser.

### 🔧 How to Access Portainer

After running the project using `docker-compose up -d`, open your browser and go to: http://localhost:9000

---
