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

## Rollback - cleaning

```
kubectl delete -f simple-web-app-hpa.yaml -n sre-challenge
kubectl delete -f simple-web-app-deployment.yaml -n sre-challenge
kubectl delete -f nginx-deployment.yaml -n sre-challenge
kubectl delete -f nginx-configmap.yaml -n sre-challenge
kubectl delete -f simple-web-app-service.yaml -n sre-challenge
kubectl delete -f nginx-service.yaml -n sre-challenge

kubectl delete namespace sre-challenge
```

## Port-forward nginx service to your local machine for testing:

kubectl port-forward svc/nginx-loadbalancer 8080:80 -n sre-challenge

## Open a browser or use curl to access the app via the load balancer:

http://localhost:8080

## From testing linter in .github/workflows/k8s-lint.yaml

```
df13e863e10c: Pull complete
f5fd8a61dc1e: Pull complete
Digest: sha256:6962d8ecbb7839637667f66e6703e6ebaae0c29dfe93a31d9968fba4324c7b8d
Status: Downloaded newer image for garethr/kubeval:latest
PASS - /k8s/namespace.yaml contains a valid Namespace (sre-challenge)
Linting k8s/nginx-configmap.yaml
PASS - /k8s/nginx-configmap.yaml contains a valid ConfigMap (sre-challenge.nginx-config)
Linting k8s/nginx-deployment.yaml
PASS - /k8s/nginx-deployment.yaml contains a valid Deployment (sre-challenge.nginx-loadbalancer)
Linting k8s/nginx-service.yaml
PASS - /k8s/nginx-service.yaml contains a valid Service (sre-challenge.nginx-loadbalancer)
Linting k8s/simple-web-app-deployment.yaml
PASS - /k8s/simple-web-app-deployment.yaml contains a valid Deployment (sre-challenge.simple-web-app)
Linting k8s/simple-web-app-hpa.yaml
PASS - /k8s/simple-web-app-hpa.yaml contains a valid HorizontalPodAutoscaler (sre-challenge.simple-web-app-hpa)
Linting k8s/simple-web-app-service.yaml
PASS - /k8s/simple-web-app-service.yaml contains a valid Service (sre-challenge.simple-web-app-service)
```

## Example - Deploying the Application

```

(⎈|colima:sre-challenge)➜  k8s git:(main) kubectl apply -f simple-web-app-deployment.yaml
kubectl apply -f simple-web-app-hpa.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-configmap.yaml
kubectl apply -f simple-web-app-service.yaml
kubectl apply -f nginx-service.yaml
deployment.apps/simple-web-app created
horizontalpodautoscaler.autoscaling/simple-web-app-hpa created
deployment.apps/nginx-loadbalancer created
configmap/nginx-config created
service/simple-web-app-service created
service/nginx-loadbalancer created

(⎈|colima:sre-challenge)➜  app git:(main) k get all
NAME                                      READY   STATUS    RESTARTS   AGE
pod/nginx-loadbalancer-55b96cd46f-mgwc6   1/1     Running   0          119s
pod/simple-web-app-6cb69cbb67-6fmhm       1/1     Running   0          119s
pod/simple-web-app-6cb69cbb67-k9c5f       1/1     Running   0          119s

NAME                             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/nginx-loadbalancer       ClusterIP   10.43.44.195    <none>        80/TCP     118s
service/simple-web-app-service   ClusterIP   10.43.170.236   <none>        8080/TCP   118s

NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-loadbalancer   1/1     1            1           119s
deployment.apps/simple-web-app       2/2     2            2           119s

NAME                                            DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-loadbalancer-55b96cd46f   1         1         1       119s
replicaset.apps/simple-web-app-6cb69cbb67       2         2         2       119s

NAME                                                     REFERENCE                   TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/simple-web-app-hpa   Deployment/simple-web-app   cpu: <unknown>/50%   2         4         2          119s



(⎈|colima:sre-challenge)➜  app git:(main) docker image ls | grep sre_challenge_app
sre_challenge_app                  v1.0.0                 749139daa8f6   56 seconds ago   210MB



(⎈|colima:sre-challenge)➜  app git:(main) ✗ kubectl port-forward svc/nginx-loadbalancer 8080:80 -n sre-challenge
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
Handling connection for 8080

(⎈|colima:sre-challenge)➜  ~ curl http://localhost:8080
Siachras Konstantinos is the most cool guy!%

```
