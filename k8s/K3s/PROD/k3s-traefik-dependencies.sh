sudo apt install -y curl wget vim git ufw
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable
curl -sfL https://get.k3s.io | sh -

if [ -f /etc/rancher/k3s/k3s.yaml ]; then
    sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
    sudo chown $(id -u):$(id -g) ~/.kube/config
else
    echo "K3s configuration file not found."
fi