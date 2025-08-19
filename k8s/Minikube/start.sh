minikube kubectl -- apply -f Secrets/
minikube kubectl -- apply -f PVCs/
minikube kubectl -- apply -f ConfigMaps/
minikube kubectl -- apply -f Deployments/
minikube kubectl -- apply -f Services/
minikube kubectl -- apply -f Ingress/
sleep 10
minikube kubectl -- apply -f CronJobs/