# Dockerized Flask Message Logger with IP Tracking

A lightweight Flask web application that allows users to submit a message through a simple web interface. Each submitted message is:

- Saved to a MySQL database along with the user's IP address.
- Logged using Python's `logging` module.
- Deployed using Docker and Docker Compose.

---

## 🧱 Project Structure

```
.
├── app
|   ├── app.py
|   ├── requirements.txt
|   ├── Dockerfile
│   ├── __init__.py
│   └── templates
│       └── form.html
└── docker-compose.yml
```

---

## 🚀 Features

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

Access the app at: [http://localhost:5000](http://localhost:5000)

---

## 🧪 Test the App

1. Open your browser and go to `http://localhost:5000`
2. Enter a message in the form.
3. Submit it — your message and IP will be saved to the DB.

---


## 🗃️ MySQL Configuration

The MySQL service is defined inside `docker-compose.yml`:

- **Host:** `db`
- **User:** `derradji`
- **Password:** `PASS1212`
- **Database:** `crudsdb`

---

## 🐙 DockerHub

You can Run it like this:

```bash
# Run The Container
docker container run -d -p 5000:5000 --name py-web derradjisenani/dockerized-flask-message-logger-with-ip-tracking:v1.0.0
```
