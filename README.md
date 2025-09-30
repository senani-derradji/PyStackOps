# PyStackOps

A production-ready Python backend using Flask + Gunicorn, with deployment options via Docker Compose or Kubernetes (Minikube).  
Includes observability (Prometheus + exporters + Grafana), Nginx reverse proxy, and support for a self-hosted GitHub Actions runner.  

<p align="center">
  <!-- Cloud & Infra -->
  <img src="https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white" />
  
  <!-- IaC & Automation -->
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white" />
  
  <!-- Containers & Orchestration -->
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
  <img src="https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white" />
  <img src="https://img.shields.io/badge/DockerCompose-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
  
  <!-- CI/CD & Version Control -->
  <img src="https://img.shields.io/badge/GitHubActions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white" />
  <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" />
  
  <!-- Monitoring & Observability -->
  <img src="https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white" />
  <img src="https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white" />
  
  <!-- Web & Backend -->
  <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white" />
  <img src="https://img.shields.io/badge/Gunicorn-499848?style=for-the-badge&logo=python&logoColor=white" />
  <img src="https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white" />
  
  <!-- Databases & Caching -->
  <img src="https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white" />
  <img src="https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=white" />
  
  <!-- OS & Scripting -->
  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" />
  <img src="https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white" />
</p>


---

## ✨ Features

- Flask application served by Gunicorn  
- MariaDB for persistent data (auth, messaging, etc.)  
- Redis as cache / session store  
- Nginx reverse proxy + TLS termination  
- Prometheus + exporters for MySQL, Redis, Nginx  
- Grafana dashboards (optional)  
- Deployment via Docker Compose or Kubernetes  
- Self-hosted Actions runner integration  

---

## 📂 Repository Structure (Overview)

```
PyStackOps/
├─ .github/
│   └─ workflows/           # CI / CD workflows
├─ IAC/                     # Infrastructure-as-code  
├─ app/                     # Flask app & templates  
├─ k8s/                     # Kubernetes manifests  
├─ nginx/                   # Reverse proxy + TLS configs  
├─ prometheus/              # Exporters & config  
├─ local_pipeline/          # Ansible playbooks / runner script  
├─ Dockerfile  
├─ docker-compose.yml  
├─ runner.sh                 # script to register runner  
├─ hosts.ini                 # Ansible inventory  
├─ playbook.yaml             # Playbook for runner setup  
└─ README.md  
```

---
## 📝 Extended Information

### 🔬 Purpose & Scope
PyStackOps is designed as a **full-stack DevOps-ready project** combining backend development, containerization, infrastructure automation, and observability. It provides a **ready-to-use production stack** for Python applications with enterprise-grade features such as:

- Automated CI/CD with **self-hosted GitHub Actions runners**.  
- Modular infrastructure provisioning via **Terraform**, enabling deployment on Azure and extensible to other cloud providers.  
- Flexible deployment: **local development with Docker Compose** or **production-grade Kubernetes clusters**.  
- Built-in **monitoring & observability**, including metrics for databases, cache, web server, and application performance.

---

### ⚙️ Key Technologies

| Layer | Technology |
|-------|------------|
| Backend | Python 3.11, Flask, Gunicorn |
| Database | MariaDB, Redis |
| Web Server | Nginx (TLS + reverse proxy) |
| CI/CD | GitHub Actions (self-hosted runner) |
| Containerization | Docker, Docker Compose |
| Orchestration | Kubernetes (Minikube, Kind, AKS) |
| IaC | Terraform (modular envs & modules) |
| Configuration Management | Ansible |
| Monitoring & Observability | Prometheus, Grafana, MySQL/Redis/Nginx exporters |
| Testing & QA | Pytest, Semgrep (optional) |

---

### 🌟 Highlights

- **Production-ready stack**: PyStackOps is immediately deployable for testing and production scenarios.  
- **Modular & scalable design**: Infrastructure and application modules are designed for scaling horizontally and integrating additional services.  
- **CI/CD workflows included**: Automated pipelines for development, testing, and deployment across multiple environments.  
- **Observability built-in**: Collect metrics, logs, and alerts to monitor app health and performance.  
- **Multi-environment support**: Dev, test, and prod configurations for easy environment isolation.  
- **Extensible**: Can integrate additional services like Vault, Helm charts, or cloud providers (AWS/GCP).  

---

### 📈 Benefits

- Rapid deployment of Python backend services with full DevOps tooling.  
- Simplifies infrastructure management with reusable Terraform modules.  
- Ensures high availability and reliability with container orchestration and monitoring.  
- Provides a learning playground for DevOps, Python backend, Kubernetes, and CI/CD practices.  

---
## 🔧 Setup & Deployment

### Setup environment variables

Create a `.env` in the project root (for Docker Compose mode):

```bash
# Database
DB_HOST=db
DB_NAME=mydatabase
DB_USER=myuser
DB_PASSWORD=securepassword

# Flask
FLASK_SECRET_KEY=your_secret_key

# Redis
REDIS_HOST=redis
REDIS_PORT=6379
```

> **Security note**: Do **not** commit `.env` with secrets. Use Kubernetes Secrets or a secrets manager in production.

---

### Run via Docker Compose

```bash
docker-compose up --build
```

Then visit your app via the configured host (e.g. `https://your-domain.com`) with TLS.

---

### Run via Kubernetes (Minikube)

```bash
minikube start
minikube addons enable ingress

# Apply resources
./start.sh
```

Add host entries in `/etc/hosts` to map domain names (`derradji.local`, `grafana.local`, `prometheus.local`) to Minikube IP.

---

## 🏃 Self-Hosted GitHub Actions Runner

You can run a GitHub Actions runner on your VM to execute workflows locally or on your infra.

### 1. Generate a Personal Access Token (PAT)

1. Go to **GitHub → Settings → Developer settings**  
2. Click **Fine-grained tokens → Generate new token**  
3. Set:
   - Name (e.g. `runner-token-PyStackOps`)  
   - Expiration  
   - Repository access: select **PyStackOps**  
   - Permissions → **Actions: Read & write**  
4. Generate and **copy** the token (you’ll see it only once)

### 2. Register the Runner

```bash
OWNER="senani-derradji"
REPO="PyStackOps"
PAT="your_token_here"

response=$(curl -s \
  -X POST \
  -H "Authorization: Bearer $PAT" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$OWNER/$REPO/actions/runners/registration-token")

token=$(echo "$response" | jq -r .token)

cd ~/actions-runner
./config.sh --unattended --url https://github.com/$OWNER/$REPO --token $token
./svc.sh install
./svc.sh start
```

You can automate this via `runner.sh` or via the provided Ansible playbook.

---

## ✅ Quick Test Workflow

Add a GitHub Actions workflow file (e.g. `.github/workflows/test-runner.yml`):

```yaml
name: Test Runner
on: [push]
jobs:
  run-on-self-hosted:
    runs-on: self-hosted
    steps:
      - name: Echo message
        run: echo "Running on my self-hosted runner!"
```

Push a commit — the job should pick your runner.

---

## 📊 Monitoring & Observability

- **Prometheus** is preconfigured in `prometheus/prometheus.yml`  
- **Exporters included:**
  - MySQL exporter
  - Redis exporter
  - Nginx metrics  
- **Grafana** can be enabled for dashboards (see `prometheus/` and `grafana/` configs)

Start Prometheus locally:

```bash
docker-compose -f prometheus/docker-compose.yml up -d
```

Access at: [http://localhost:9090](http://localhost:9090)  
Grafana (if enabled): [http://localhost:3000](http://localhost:3000)

---

## ☁️ Infrastructure as Code (Terraform)

Infrastructure is provisioned via Terraform under `IAC/`.

- Modular design with `envs/` (dev, test, prod) and `modules/`
- Azure resources supported:
  - Virtual Networks, Subnets, NSGs
  - AKS (Kubernetes Service)
  - ACR (Azure Container Registry)
  - Virtual Machines

Run example:

```bash
cd IAC/envs/dev
terraform init
terraform apply
```

---

## 🗺️ Roadmap

- [ ] Add Grafana dashboards as code  
- [ ] Integrate HashiCorp Vault for secret management  
- [ ] Expand Terraform modules for AWS / GCP  
- [ ] Add Helm charts for Kubernetes deployments  
- [ ] Enhance CI/CD with dynamic preview environments  

---

## 🛠 Troubleshooting & Tips

- If `config.sh` says “already configured”, run `./svc.sh uninstall` or `./config.sh remove` before re-running setup  
- Use **absolute paths** (don’t rely on `~`) in scripts  
- Manage PAT securely with **Ansible Vault** or environment variables  
- For production, rotate your PAT often  
- Check `systemctl status actions.runner.*` to debug the runner service  

---

## 📄 About

PyStackOps is built by **senani-derradji**.  
It supports modern DevOps flows with self-hosted CI, full observability, and flexible deployment.

![Animated GIF](https://s5.ezgif.com/tmp/ezgif-5d2c7121e6a2b9.gif)
