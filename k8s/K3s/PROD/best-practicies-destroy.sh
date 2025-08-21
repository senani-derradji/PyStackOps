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

delete_resource() {
  local kind=$1
  local file=$2

  log "Deleting $kind → $file"
  kubectl delete -f "$file" --ignore-not-found=true
}

# Traefik Ingress
delete_resource "Ingress" ../Ingress/Traefik-Ingress.yaml

# Nginx
delete_resource "Service" ../../Services/Nginx-Service.yaml
delete_resource "Deployment" ../../Deployments/Nginx-Deployment.yaml

# Flask + HPA
delete_resource "Service" ../../Services/Flask-Service.yaml
delete_resource "HPA" ../../Autoscalers/HPA/Flask-HPA.yaml
delete_resource "Deployment" ../../Deployments/Flask-Deployment.yaml

# Redis
delete_resource "Service" ../../Services/Redis-Service.yaml
delete_resource "Deployment" ../../Deployments/Redis-Deployment.yaml

# MySQL StatefulSet
delete_resource "Service" ../../Kind/DBs/Mysql-Statefulset-Service.yaml
delete_resource "StatefulSet" ../../Kind/DBs/Mysql-Statefulset.yaml
# Optional VPA
# delete_resource "VPA" ../../Minikube/VPA/Mysql-VPA.yaml

# Base configs (Secrets, ConfigMaps, PVCs)
log "Deleting base resources..."
kubectl delete --recursive -f ../../Secrets/ --ignore-not-found=true
kubectl delete --recursive -f ../../ConfigMaps/ --ignore-not-found=true
kubectl delete --recursive -f ../PVCs/ --ignore-not-found=true
success "Base resources deleted."

# Optional: HPA/VPA dependencies (if installed manually, skip automatic removal)

success "🔥 All resources destroyed successfully!"
