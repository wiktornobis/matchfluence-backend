# Troubleshooting

This document contains useful commands for debugging and monitoring the local Wedly Kubernetes environment.

---

# Health Check

## Check Namespace

```bash
kubectl get namespaces
```

---

## Check Pods

Development:

```bash
kubectl get pods -n wedly-dev
```

Test:

```bash
kubectl get pods -n wedly-test
```

Production:

```bash
kubectl get pods -n wedly-prod
```

---

## Check Deployments

```bash
kubectl get deployments -n wedly-dev
```

---

## Check Services

```bash
kubectl get svc -n wedly-dev
```

---

## Check Helm Release

```bash
helm list -n wedly-dev
```

---

# Backend Logs

Follow backend logs:

```bash
kubectl logs -f \
deployment/wedly-backend \
-n wedly-dev
```

---

# PostgreSQL Logs

```bash
kubectl logs -f \
deployment/postgres-db \
-n wedly-dev
```

---

# Elasticsearch Logs

```bash
kubectl logs -f \
deployment/elasticsearch \
-n wedly-dev
```

---

# Kubernetes Debugging

## Describe Pod

Useful when a Pod is not starting.

List Pods:

```bash
kubectl get pods -n wedly-dev
```

Describe Pod:

```bash
kubectl describe pod POD_NAME \
-n wedly-dev
```

---

## Check Events

```bash
kubectl get events \
-n wedly-dev
```

Sort by creation time:

```bash
kubectl get events \
--sort-by=.metadata.creationTimestamp \
-n wedly-dev
```

---

## Check Rollout Status

Backend:

```bash
kubectl rollout status \
deployment/wedly-backend \
-n wedly-dev
```

PostgreSQL:

```bash
kubectl rollout status \
deployment/postgres-db \
-n wedly-dev
```

Elasticsearch:

```bash
kubectl rollout status \
deployment/elasticsearch \
-n wedly-dev
```

---

# Port Forwarding

## Backend

```bash
kubectl port-forward \
svc/backend-service \
8080:8080 \
-n wedly-dev
```

Health endpoint:

```
http://localhost:8080/actuator/health
```

---

## PostgreSQL

```bash
kubectl port-forward \
svc/postgres-service \
5432:5432 \
-n wedly-dev
```

---

## Elasticsearch

```bash
kubectl port-forward \
svc/elasticsearch-service \
9200:9200 \
-n wedly-dev
```

---

# Minikube

## Status

```bash
minikube status
```

---

## Dashboard

```bash
minikube dashboard
```

---

## Kubernetes Cluster Information

```bash
kubectl cluster-info
```

---

## Node Information

```bash
kubectl get nodes
```

---

# Docker

Check Docker images inside Minikube:

```bash
eval $(minikube docker-env)

docker images
```

---

# Useful Commands

## Check Everything

```bash
kubectl get all -n wedly-dev
```

---

## Check Persistent Volume Claims

```bash
kubectl get pvc -n wedly-dev
```

---

## Check ConfigMaps

```bash
kubectl get configmaps -n wedly-dev
```

---

## Check Secrets

```bash
kubectl get secrets -n wedly-dev
```

---

# Common Issues

## Backend Pod is not starting

Check:

1. Pod status

```bash
kubectl get pods -n wedly-dev
```

2. Pod description

```bash
kubectl describe pod POD_NAME \
-n wedly-dev
```

3. Backend logs

```bash
kubectl logs -f \
deployment/wedly-backend \
-n wedly-dev
```

---

## Database Connection Error

Check:

* PostgreSQL Pod
* PostgreSQL Service
* Secret
* ConfigMap

```bash
kubectl get pods -n wedly-dev

kubectl get svc -n wedly-dev

kubectl get secrets -n wedly-dev

kubectl get configmaps -n wedly-dev
```

---

## Elasticsearch Connection Error

Check:

```bash
kubectl get pods -n wedly-dev

kubectl logs -f \
deployment/elasticsearch \
-n wedly-dev
```

---

## Deployment Failed

Check:

```bash
helm list -n wedly-dev

kubectl get events \
-n wedly-dev

kubectl get all \
-n wedly-dev
```
