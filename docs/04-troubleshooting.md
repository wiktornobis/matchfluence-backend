# Troubleshooting

This document contains useful commands for debugging and monitoring the local Matchfluence Kubernetes environment.

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
kubectl get pods -n matchfluence-dev
```

Test:

```bash
kubectl get pods -n matchfluence-test
```

Production:

```bash
kubectl get pods -n matchfluence-prod
```

---

## Check Deployments

```bash
kubectl get deployments -n matchfluence-dev
```

---

## Check Services

```bash
kubectl get svc -n matchfluence-dev
```

---

## Check Helm Release

```bash
helm list -n matchfluence-dev
```

---

# Backend Logs

Follow backend logs:

```bash
kubectl logs -f \
deployment/matchfluence-backend \
-n matchfluence-dev
```

---

# PostgreSQL Logs

```bash
kubectl logs -f \
deployment/postgres-db \
-n matchfluence-dev
```

---

# Elasticsearch Logs

```bash
kubectl logs -f \
deployment/elasticsearch \
-n matchfluence-dev
```

---

# Kubernetes Debugging

## Describe Pod

Useful when a Pod is not starting.

List Pods:

```bash
kubectl get pods -n matchfluence-dev
```

Describe Pod:

```bash
kubectl describe pod POD_NAME \
-n matchfluence-dev
```

---

## Check Events

```bash
kubectl get events \
-n matchfluence-dev
```

Sort by creation time:

```bash
kubectl get events \
--sort-by=.metadata.creationTimestamp \
-n matchfluence-dev
```

---

## Check Rollout Status

Backend:

```bash
kubectl rollout status \
deployment/matchfluence-backend \
-n matchfluence-dev
```

PostgreSQL:

```bash
kubectl rollout status \
deployment/postgres-db \
-n matchfluence-dev
```

Elasticsearch:

```bash
kubectl rollout status \
deployment/elasticsearch \
-n matchfluence-dev
```

---

# Port Forwarding

## Backend

```bash
kubectl port-forward \
svc/backend-service \
8080:8080 \
-n matchfluence-dev
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
-n matchfluence-dev
```

---

## Elasticsearch

```bash
kubectl port-forward \
svc/elasticsearch-service \
9200:9200 \
-n matchfluence-dev
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
kubectl get all -n matchfluence-dev
```

---

## Check Persistent Volume Claims

```bash
kubectl get pvc -n matchfluence-dev
```

---

## Check ConfigMaps

```bash
kubectl get configmaps -n matchfluence-dev
```

---

## Check Secrets

```bash
kubectl get secrets -n matchfluence-dev
```

---

# Common Issues

## Backend Pod is not starting

Check:

1. Pod status

```bash
kubectl get pods -n matchfluence-dev
```

2. Pod description

```bash
kubectl describe pod POD_NAME \
-n matchfluence-dev
```

3. Backend logs

```bash
kubectl logs -f \
deployment/matchfluence-backend \
-n matchfluence-dev
```

---

## Database Connection Error

Check:

* PostgreSQL Pod
* PostgreSQL Service
* Secret
* ConfigMap

```bash
kubectl get pods -n matchfluence-dev

kubectl get svc -n matchfluence-dev

kubectl get secrets -n matchfluence-dev

kubectl get configmaps -n matchfluence-dev
```

---

## Elasticsearch Connection Error

Check:

```bash
kubectl get pods -n matchfluence-dev

kubectl logs -f \
deployment/elasticsearch \
-n matchfluence-dev
```

---

## Deployment Failed

Check:

```bash
helm list -n matchfluence-dev

kubectl get events \
-n matchfluence-dev

kubectl get all \
-n matchfluence-dev
```
