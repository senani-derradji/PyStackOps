kubectl apply -f ../Secrets/
kubectl apply -f ../ConfigMaps/
kubectl apply -f az-secrets.yaml
kubectl apply -f az-configmap.yaml

# echo "MYSQL"
# kubectl apply -f ../Deployments/Mysql-Deployment.yaml
# kubectl apply -f ../Services/Mysql-Service.yaml

echo "REDIS"
kubectl apply -f ../Deployments/Redis-Deployment.yaml
kubectl apply -f ../Services/Redis-Service.yaml
sleep 5
echo "Flask"
kubectl apply -f Flask-Deployment-az.yaml
kubectl apply -f ../Services/Flask-Service.yaml
sleep 5
echo "Nginx"
kubectl apply -f ../Deployments/Nginx-Deployment.yaml
kubectl apply -f ../Services/Nginx-Service.yaml

