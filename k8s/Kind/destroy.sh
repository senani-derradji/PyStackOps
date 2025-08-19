#!/bin/bash

echo "Delete Flask HPA"
kubectl delete -f ../Autoscalers/HPA/Flask-HPA.yaml --ignore-not-found

echo "Delete Flask"
kubectl delete -f ../Services/Flask-Service.yaml --ignore-not-found
kubectl delete -f ../Deployments/Flask-Deployment.yaml --ignore-not-found
sleep 1

echo "Delete Redis"
kubectl delete -f ../Services/Redis-Service.yaml --ignore-not-found
kubectl delete -f ../Deployments/Redis-Deployment.yaml --ignore-not-found
sleep 1

echo "Delete MySQL"
kubectl delete -f DBs/Mysql-Statefulset-Service.yaml --ignore-not-found
kubectl delete -f DBs/Mysql-Statefulset.yaml --ignore-not-found
sleep 3

echo "Delete PVCs"
kubectl delete -f ../PVCs/ --ignore-not-found

echo "Delete PV"
kubectl delete -f Kind-PVCs/Storage-PV.yaml --ignore-not-found

echo "Delete ConfigMaps and Secrets"
kubectl delete -f ../ConfigMaps/ --ignore-not-found
kubectl delete -f ../Secrets/ --ignore-not-found

echo "✅ All resources deleted!"
