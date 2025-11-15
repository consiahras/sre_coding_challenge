# Kubernetes Deployment for Simple Web Application with Nginx Load Balancer

## Directory Structure

This directory contains the following Kubernetes manifest files:

```
k8s/
├── namespace.yaml # Namespace for logical separation
├── simple-web-app-deployment.yaml # Deployment of simple Python Flask app with 2 replicas
├── simple-web-app-hpa.yaml # Horizontal Pod Autoscaler for app scaling 2-4 pods
├── nginx-deployment.yaml # Nginx Deployment acting as load balancer
├── nginx-configmap.yaml # Nginx configuration for proxy to app service
├── simple-web-app-service.yaml # Internal Service exposing app pods on port 8080
├── nginx-service.yaml # Internal Service exposing nginx pods on port 80
```

## Description of Each File

- **namespace.yaml:** Creates a Kubernetes namespace (`sre-challenge`) to isolate all resources for this project.
- **simple-web-app-deployment.yaml:** Deploys the Python Flask app container with 2 replicas initially, including resource controls and health checks.
- **simple-web-app-hpa.yaml:** Configures Horizontal Pod Autoscaler to scale app replicas between 2 and 4 based on CPU load.
- **nginx-deployment.yaml:** Runs an nginx pod using the official lightweight image, configured to load balance incoming traffic to the app.
- **nginx-configmap.yaml:** Provides the nginx load balancer configuration, defining proxy rules to route HTTP requests to the app service.
- **simple-web-app-service.yaml:** Exposes the app deployment pods internally via a ClusterIP Service on port 8080.
- **nginx-service.yaml:** Exposes nginx pods internally via a ClusterIP Service on port 80, which in turn routes traffic to the app service.

## Application Traffic Flow and Architecture

- External requests (or local test connections) first hit the **nginx load balancer** at port 80.
- The nginx proxy forwards incoming HTTP traffic to the **simple web app service** internally on port 8080.
- The app service load balances requests among the multiple app pod replicas.
- Kubernetes manages the desired number of app pods, uses **readiness and liveness probes** to keep unhealthy pods from serving traffic, and automatically restarts failing pods.
- The **Horizontal Pod Autoscaler** dynamically increases or decreases the number of app replicas between 2 to 4 based on CPU usage, ensuring scalability under load.

## Deploying and Testing on Colima Kubernetes

1. Verify your current Kubernetes context is Colima:

```
kubectl config current-context
```

## Local testing with colima

```
#Apply the namespace first:
kubectl apply -f namespace.yaml

#Apply all other manifests:
kubectl apply -f simple-web-app-deployment.yaml
kubectl apply -f simple-web-app-hpa.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-configmap.yaml
kubectl apply -f simple-web-app-service.yaml
kubectl apply -f nginx-service.yaml


#confirm everything is running
kubectl get pods -n sre-challenge
kubectl get hpa -n sre-challenge
kubectl get svc -n sre-challenge
```

## Port-forward nginx service to your local machine for testing:

kubectl port-forward svc/nginx-loadbalancer 8080:80 -n sre-challenge

## Open a browser or use curl to access the app via the load balancer:

http://localhost:8080

## testing linter

Just a simple comment to test functionality of my linter under .github/workflows/k8s-lint.yaml
