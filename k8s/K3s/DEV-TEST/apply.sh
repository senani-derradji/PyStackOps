kubectl apply -f ../Secrets/
kubectl apply -f ../ConfigMaps/
kubectl apply -f PVCs/

echo "MYSQL"
kubectl apply -f ../Deployments/Mysql-Deployment.yaml
kubectl apply -f ../Services/Mysql-Service.yaml

sleep 20
echo "REDIS"
kubectl apply -f ../Deployments/Redis-Deployment.yaml
kubectl apply -f ../Services/Redis-Service.yaml
sleep 5
echo "Flask"
kubectl apply -f ..//Deployments/Flask-Deployment.yaml
kubectl apply -f ../Services/Flask-Service.yaml
sleep 5
echo "Nginx"
kubectl apply -f ../Deployments/Nginx-Deployment.yaml
kubectl apply -f ../Services/Nginx-Service.yaml
sleep 5
echo "Traefik"
kubectl apply -f ../Ingress/Traefik-Ingress.yaml