# Kubernetes

This document describes the Kubernetes architecture used for local development and deployment of Wedly Backend.

---

# Architecture Overview

The application is deployed to Kubernetes using Helm.

```
Spring Boot

↓

Docker Image

↓

Helm Chart

↓

Kubernetes Namespace

↓

ConfigMap + Secret

↓

PostgreSQL
Elasticsearch
Backend

↓

ClusterIP Services

↓

Port Forward

↓

Local Development
```

---

# Environments

Each environment has its own Kubernetes namespace.

| Environment | Namespace         |
| ----------- | ----------------- |
| Development | wedly-dev  |
| Test        | wedly-test |
| Production  | wedly-prod |

Deploy environment:

```bash
./k8s/scripts/deploy.sh dev
```

Remove environment:

```bash
./k8s/scripts/undeploy.sh dev
```

---

# Project Structure

```
k8s/

env/

helm/

scripts/
```

---

# Environment Configuration

Environment-specific configuration is stored in:

```
k8s/env/

config-dev.env
secret-dev.env

config-test.env
secret-test.env

config-prod.env
secret-prod.env
```

## Config Files

Config files contain non-sensitive application settings.

Examples:

* Spring profile
* Database URL
* Elasticsearch URL

---

## Secret Files

Secret files contain sensitive configuration.

Examples:

* Database username
* Database password

Secrets are automatically converted into Kubernetes Secrets during deployment.

---

# Helm

Helm is used to manage Kubernetes resources.

The Helm Chart is located in:

```
k8s/helm/wedly-backend
```

Helm manages:

* Namespace
* PostgreSQL
* Elasticsearch
* Backend
* Services

Deployment:

```bash
helm upgrade --install ...
```

is executed automatically by the deployment script.

---

# Docker

Backend runs as a Docker container.

The deployment script automatically:

1. switches Docker to Minikube
2. builds Docker image
3. deploys image to Kubernetes

Docker image:

```
wedly-backend:latest
```

---

# Kubernetes Resources

## Namespace

Provides isolation between environments.

Examples:

```
wedly-dev

wedly-test

wedly-prod
```

---

## ConfigMap

Stores non-sensitive configuration.

Examples:

* Spring profile
* Database URL
* Elasticsearch URL

---

## Secret

Stores sensitive configuration.

Examples:

* Database username
* Database password

---

## PostgreSQL

Single PostgreSQL instance.

Service:

```
postgres-service
```

---

## Elasticsearch

Single-node Elasticsearch instance.

Service:

```
elasticsearch-service
```

---

## Backend

Spring Boot application.

Service:

```
backend-service
```

---

## Services

All services use ClusterIP.

| Service               | Purpose       |
| --------------------- | ------------- |
| postgres-service      | PostgreSQL    |
| elasticsearch-service | Elasticsearch |
| backend-service       | Spring Boot   |

External access is provided through Kubernetes Port Forwarding.

---

# Persistent Storage

Persistent Volume Claims are used for:

* PostgreSQL
* Elasticsearch

This prevents data loss after Pod restarts.

Check PVCs:

```bash
kubectl get pvc -n wedly-dev
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

Open:

```
http://localhost:8080
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

# Deployment Flow

Running:

```bash
./k8s/scripts/deploy.sh dev
```

performs the following steps:

```
Build Docker Image

↓

Switch Docker to Minikube

↓

Create or Update Namespace

↓

Create or Update ConfigMap

↓

Create or Update Secret

↓

Deploy or Upgrade Helm Chart

↓

Restart Backend

↓

Verify Deployment
```

---

# Verify Kubernetes Environment

Check Pods:

```bash
kubectl get pods -n wedly-dev
```

Check Services:

```bash
kubectl get svc -n wedly-dev
```

Check Deployments:

```bash
kubectl get deployments -n wedly-dev
```

Check Helm Release:

```bash
helm list -n wedly-dev
```

---

# Local Development Workflow

```
Code Changes

↓

./k8s/scripts/deploy.sh dev

↓

Backend Updated

↓

kubectl port-forward

↓

Continue Development
```
