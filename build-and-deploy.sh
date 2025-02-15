#!/usr/bin/env bash

set -e

echo "Scaling down deployment..."
kubectl scale deployment.apps/kratix-platform-controller-manager --replicas=0 -n kratix-platform-system

echo "Building Docker image..."
docker build -t kratix-controller:local .

echo "Loading image into Minikube..."
minikube image rm kratix-controller:local
minikube image load kratix-controller:local

echo "Scaling up deployment..."
kubectl scale deployment.apps/kratix-platform-controller-manager --replicas=1 -n kratix-platform-system

echo "Deployment completed!"

