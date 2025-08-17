# 🚀 Python-Dockerized-Backend (Flask/Gunicorn + MariaDB + Redis + Nginx)
Production-ready Python backend with two deployment paths:

1) 🐳 **Docker Compose** — Nginx (reverse proxy + TLS) → Flask/Gunicorn; Flask → MariaDB & Redis  
2) ☸️ **Kubernetes (Minikube)** — App + Redis + MariaDB, Observability (Prometheus + exporters + Grafana), **name‑based virtual hosts**

---

## ✨ Features

- ⚙️ **Flask** served by **Gunicorn**
- 🗃️ **MariaDB** for persistent data (auth, messages, etc.)
- ⚡ **Redis** for caching
- 🌐 **Nginx** reverse proxy with **HTTPS** termination (Compose path)
- 📊 **Prometheus** + **Exporters** (MySQL, Redis, Nginx)
- 📈 **Grafana** dashboards
- 🔐 `.env` for local secrets (Compose), **K8s Secrets** for cluster
- 🧠 Login/Register flow with persistent user data

---

## 🧱 Repository Structure (Overview)

```
Python-Dockerized-Backend/
├─ app/
│  ├─ app.py
│  ├─ requirements.txt
│  ├─ Dockerfile
│  └─ templates/
│     ├─ register.html
│     └─ login.html
│
├─ nginx/
│  ├─ nginx.conf
│  └─ certs/
│     ├─ fullchain.pem
│     └─ privkey.pem
│
├─ prometheus/
│  ├─ mysql-exporter/
│  └─ prometheus.yml
│
├─ k8s/
│  └─ Minikube/
│     ├─ ConfigMaps/
│     │  ├─ Nginx-ConfigMap.yaml
│     │  ├─ mysql-exporter-configMap.yaml
│     │  └─ prometheus-configMap.yaml
│     ├─ Deployments/
│     │  ├─ Exporters/
│     │  │  ├─ mysql-exporter-Deployment.yaml
│     │  │  ├─ nginx-exporter-Deployment.yaml
│     │  │  └─ redis-exporter-Deployment.yaml
│     │  ├─ Flask-Deployment.yaml
│     │  ├─ Grafana-Deployment.yaml
│     │  ├─ Mysql-Deployment.yaml
│     │  ├─ Nginx-Deployment.yaml
│     │  ├─ Prometheus-Deployment.yaml
│     │  └─ Redis-Deployment.yaml
│     ├─ Ingress/
│     │  ├─ Monitoring-Ingress-Service.yaml
│     │  └─ Nginx-Ingress-Service.yaml
│     ├─ PVCs/
│     │  └─ PVC.yaml
│     ├─ Secrets/
│     │  └─ Secrets.yaml
│     └─ Services/
│        ├─ Exporters/
│        │  ├─ mysql-exporter-Service.yaml
│        │  ├─ nginx-exporter-Service.yaml
│        │  └─ redis-exporter-Service.yaml
│        ├─ Flask-Service.yaml
│        ├─ Grafana-Service.yaml
│        ├─ Mysql-Service.yaml
│        ├─ Nginx-Service.yaml
│        ├─ Prometheus-Service.yaml
│        └─ Redis-Service.yaml
│
├─ .env
├─ docker-compose.yml
├─ start.sh
├─ .dockerignore
├─ .gitignore
└─ README.md
```

---

## #1 Architecture — Docker Compose

```
 +------------+
 |   Client   |
 +------------+
       |
 HTTPS | 443 (TLS)
       v
+-------------+        HTTP 5000
|   Nginx     | ─────────────────► +-------------+
|  (TLS RP)   |                    |  Flask App  |
+-------------+                    | (Gunicorn)  |
                                   +-------------+
                                          | 
                                          |   
                                          v 
+-------------+                     +-------------+
|  MariaDB    |  ◄──────────────►   |   Redis     |
+-------------+                     +-------------+
           (Flask connects to MariaDB and Redis)
```

- TLS termination via `nginx/certs/{fullchain.pem,privkey.pem}`
- Reverse proxy & caching in `nginx/nginx.conf`

---

## #2 Architecture — Kubernetes (Minikube, name‑based vhosts)

```
                 Ingress (Nginx Ingress Controller)
                 ├───────────── derradji.local  ───────────► App (Nginx → Flask)
                 ├───────────── grafana.local   ───────────► Grafana
                 └───────────── prometheus.local ──────────► Prometheus

      +-----------+      +---------+      +---------+
      |  Flask    | ◄──► | MariaDB | ◄──► |  Redis  |
      +-----------+      +---------+      +---------+

(Services, ConfigMaps, Deployments, Secrets, PVCs under k8s/Minikube/)
```

- **Ingress rules (host-based)**
  - `derradji.local` → application (Nginx/Flask)
  - `grafana.local` → Grafana
  - `prometheus.local` → Prometheus
  - You can change these in `k8s/Minikube/Ingress/Nginx-Ingress-Service.yaml` and `Monitoring-Ingress-Service.yaml`.

- **Exporters**: MySQL, Redis, Nginx exporters scraped by Prometheus
- **PVCs**: Persistent volumes for DB and (optionally) Prometheus/Grafana
- **Secrets**: App/DB credentials in `Secrets/Secrets.yaml` (base64-encoded)

---

## 🔐 Environment Variables (.env) — Compose

Create a `.env` in the repo root:

```
# Database settings
DB_HOST=db
DB_NAME=mydatabase
DB_USER=myuser
DB_PASSWORD=securepassword

# Flask
FLASK_SECRET_KEY=change_me

# Redis
REDIS_HOST=redis
REDIS_PORT=6379
```

> For Kubernetes, these values are provided via **K8s Secrets** (`k8s/Minikube/Secrets/Secrets.yaml`). Don’t commit real secrets.

---

## 🐳 How to Run — Docker Compose

```bash
# 1) Clone
git clone https://github.com/senani-derradji/Python-Dockerized-Backend.git
cd Python-Dockerized-Backend

# 2) Ensure .env exists (see above) and TLS certs are in nginx/certs/
#    fullchain.pem and privkey.pem (use your real certs or mkcert/self-signed)

# 3) Build & run
docker-compose up --build
# or in background:
# docker-compose up -d --build
```

Open the app: **https://derradji.com** (or the host configured in your Nginx cert).  
Optional: Portainer (if enabled in compose) at `http://localhost:9000`.

**Quick test**
```
wrk -t4 -c100 -d30s https://derradji.com
```

---

## ☸️ How to Run — Kubernetes (Minikube)

### Prereqs
- Minikube, kubectl
- Nginx Ingress Controller enabled in Minikube

### One‑shot apply
Use the helper script to apply **everything** (Secrets, ConfigMaps, PVCs, Deployments, Services, Exporters, Ingresses):
```bash
./start.sh
```

> The script mirrors manual steps below. Inspect/edit it before running in your environment.

### Manual steps (if you prefer)
```bash
minikube start
minikube addons enable ingress

# 1) Secrets
kubectl apply -f k8s/Minikube/Secrets/Secrets.yaml

# 2) ConfigMaps
kubectl apply -f k8s/Minikube/ConfigMaps/

# 3) PVCs
kubectl apply -f k8s/Minikube/PVCs/PVC.yaml

# 4) Core Services & Deployments
kubectl apply -f k8s/Minikube/Deployments/Mysql-Deployment.yaml
kubectl apply -f k8s/Minikube/Services/Mysql-Service.yaml

kubectl apply -f k8s/Minikube/Deployments/Redis-Deployment.yaml
kubectl apply -f k8s/Minikube/Services/Redis-Service.yaml

kubectl apply -f k8s/Minikube/Deployments/Flask-Deployment.yaml
kubectl apply -f k8s/Minikube/Services/Flask-Service.yaml

kubectl apply -f k8s/Minikube/Deployments/Nginx-Deployment.yaml
kubectl apply -f k8s/Minikube/Services/Nginx-Service.yaml

# 5) Observability
kubectl apply -f k8s/Minikube/Deployments/Prometheus-Deployment.yaml
kubectl apply -f k8s/Minikube/Services/Prometheus-Service.yaml

kubectl apply -f k8s/Minikube/Deployments/Grafana-Deployment.yaml
kubectl apply -f k8s/Minikube/Services/Grafana-Service.yaml

# 6) Exporters
kubectl apply -f k8s/Minikube/Deployments/Exporters/
kubectl apply -f k8s/Minikube/Services/Exporters/

# 7) Ingress (host-based)
kubectl apply -f k8s/Minikube/Ingress/Nginx-Ingress-Service.yaml
kubectl apply -f k8s/Minikube/Ingress/Monitoring-Ingress-Service.yaml
```

### /etc/hosts entries (host‑based vhosts)
Get the Minikube IP:
```bash
minikube ip
# e.g. 192.168.49.2
```
Add to your host machine’s `/etc/hosts`:
```
192.168.49.2 derradji.local
192.168.49.2 grafana.local
192.168.49.2 prometheus.local
```

> You can change these hostnames in `Repo/k8s/Minikube/Ingress/Nginx-Ingress-Service.yaml` (for app) and the monitoring ingress file for Grafana/Prometheus.

### Access
- App: `http://derradji.local`
- Grafana: `http://grafana.local`
- Prometheus: `http://prometheus.local`

**Alternative (no Ingress):**
```bash
kubectl port-forward svc/flask-service 5000:5000
kubectl port-forward svc/prometheus-service 9090:9090
kubectl port-forward svc/grafana-service 3000:3000
```

---

## 📦 Prometheus Scraping

- Base config: `prometheus/prometheus.yml` (Compose) or `k8s/Minikube/ConfigMaps/prometheus-configMap.yaml` (K8s)
- Targets:
  - `mysql-exporter` — DB metrics
  - `redis-exporter` — Redis metrics
  - `nginx-exporter` — Nginx metrics
  - (Optional) Flask app metrics if exposed

---

## 🔑 Auth & App Notes

- Register/Login flow persists users in MariaDB
- Sessions secured via `FLASK_SECRET_KEY` (Compose) or K8s Secret
- Redis used as a cache layer

---

## 🧰 Portainer (Compose Only — Optional)

If enabled in `docker-compose.yml`, Portainer is available at:
```
http://localhost:9000
```

---

## 🧪 Quick Functional Test

1. Open the app (Compose: your domain with TLS; K8s: `http://derradji.local`)
2. Register/Login
3. Submit a message — it should persist in MariaDB
4. Open `http://prometheus.local` and confirm targets are **UP**
5. Open `http://grafana.local` and add/import dashboards for MySQL/Redis/Nginx

---

## 🛠️ Common Troubleshooting

- **Ingress 404/loops**: Confirm hostnames in `/etc/hosts` map to *current* `minikube ip`. Clear site data for `*.local` domains after changes.
- **DB connection**: Verify Secrets/Env, Service names (`db` in Compose, `mysql-service` in K8s), and that the pod is Ready.
- **PVC pending**: Ensure Minikube has a default StorageClass (it does by default) and that `PVC.yaml` matches it.
- **Exporters down**: Check Service selectors/labels and that Prometheus job labels match service names.

---

## 📜 Scripts

- `start.sh` — applies **everything** (Secrets, ConfigMaps, PVCs, Deployments, Services, Exporters, Ingresses).

---

## 🔒 Security Notes

- Never commit real TLS keys or production secrets.
- For K8s, prefer an external secret manager or sealed secrets for production.
- For public ingress/TLS on real clusters, consider `cert-manager` with Let’s Encrypt.

---
