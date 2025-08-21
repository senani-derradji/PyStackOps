#!/bin/bash
set -euo pipefail

# ===== Colors =====
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

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

# ===== 1. Install k3s =====
log "Installing k3s..."
curl -sfL https://get.k3s.io | sh - || error "k3s installation failed"

# ===== 2. Configure kubeconfig =====
log "Configuring kubeconfig..."
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
export KUBECONFIG=~/.kube/config
success "kubeconfig set to ~/.kube/config"

# ===== 3. Verify cluster =====
log "Checking cluster nodes..."
kubectl get nodes || error "Failed to get nodes"

# ===== 4. Check Traefik Ingress Controller =====
log "Checking Traefik status..."
if kubectl get pods -n kube-system | grep -q traefik; then
  success "Traefik Ingress Controller is running ✅"
else
  error "Traefik not found. Check your k3s installation ❌"
fi

success "🚀 k3s installed and Traefik verified!"
