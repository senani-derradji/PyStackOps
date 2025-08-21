#!/bin/bash
set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log() {
  echo -e "${BLUE}[INFO] $1${NC}"
}

success() {
  echo -e "${GREEN}[SUCCESS] $1${NC}"
}

error() {
  echo -e "${RED}[ERROR] $1${NC}"
  exit 1
}

apply_and_wait() {
  local kind=$1
  local file=$2

  log "Applying $kind → $file"
  kubectl apply -f "$file"

  if [[ "$kind" == "Deployment" || "$kind" == "StatefulSet" ]]; then
    local name
    name=$(grep -m1 'name:' "$file" | awk '{print $2}')
    log "Waiting for $kind/$name rollout..."
    kubectl rollout status "$kind" "$name" || error "$kind/$name failed to roll out"
  fi
}

# Base configs
log "Applying base resources (Secrets, ConfigMaps, PVCs)..."
kubectl apply --recursive -f ../../Secrets/
kubectl apply --recursive -f ../../ConfigMaps/
kubectl apply --recursive -f ../PVCs/
success "Base resources applied."

# HPA Dependencies
log "Installing HPA dependencies..."
(cd ../../Autoscalers/HPA && ./install-dependencies.sh)
success "HPA dependencies installed."

# Optional: VPA
# log "Installing VPA dependencies..."
# (cd ../../Minikube/VPA && ./install-dependencies.sh)
# success "VPA dependencies installed."

# MySQL StatefulSet
apply_and_wait "StatefulSet" ../../Kind/DBs/Mysql-Statefulset.yaml
kubectl apply -f ../../Kind/DBs/Mysql-Statefulset-Service.yaml
# Optional VPA
# kubectl apply -f ../../Minikube/VPA/Mysql-VPA.yaml

# Redis
apply_and_wait "Deployment" ../../Deployments/Redis-Deployment.yaml
kubectl apply -f ../../Services/Redis-Service.yaml

# Flask + HPA
apply_and_wait "Deployment" ../../Deployments/Flask-Deployment.yaml
kubectl apply -f ../../Autoscalers/HPA/Flask-HPA.yaml
kubectl apply -f ../../Services/Flask-Service.yaml

# Nginx
apply_and_wait "Deployment" ../../Deployments/Nginx-Deployment.yaml
kubectl apply -f ../../Services/Nginx-Service.yaml

# Traefik Ingress
log "Applying Traefik Ingress..."
kubectl apply -f ../Ingress/Traefik-Ingress.yaml

success "🚀 All resources deployed successfully!"
