kubectl apply -f ../Secrets/
kubectl apply -f ../ConfigMaps/
kubectl apply -f Kind-PVCs/Storage-PV.yaml
kubectl apply -f ../PVCs/

echo "MYSQL"
# kubectl apply -f ../Deployments/Mysql-Deployment.yaml
# kubectl apply -f ../Services/Mysql-Service.yaml
kubectl apply -f DBs/Mysql-Statefulset.yaml
kubectl apply -f DBs/Mysql-Statefulset-Service.yaml
sleep 20
echo "REDIS"
kubectl apply -f ../Deployments/Redis-Deployment.yaml
kubectl apply -f ../Services/Redis-Service.yaml
sleep 5
echo "Flask"
kubectl apply -f ..//Deployments/Flask-Deployment.yaml
kubectl apply -f ../Services/Flask-Service.yaml
# sleep 5
# kubectl apply -f ../Autoscalers/HPA/Flask-HPA.yaml
# sleep 5
# echo "Ingress"
# kubectl apply -f ../Ingress/
# sleep 3
# kubectl apply -f ../Deployments/Prometheus-Deployment.yaml
# kubectl apply -f ../Services/Prometheus-Service.yaml
# sleep 5
# kubectl apply -f ../Deployments/Exporters/
# kubectl apply -f ../Services/Exporters/
# sleep 5
# echo "Grafana"
# kubectl apply -f ../Deployments/Grafana-Deployment.yaml
# kubectl apply -f ../Services/Grafana-Service.yaml
# sleep 5
# kubectl apply -f ../NetworkPolicies/
# echo "....."