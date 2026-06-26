# Wedly Backend

Backend service for Wedly platform.

---

# Tech Stack

- Java 21
- Spring Boot 4
- PostgreSQL
- Elasticsearch
- Liquibase
- Docker
- Kubernetes
- Helm
- Minikube

---

# Prerequisites

Install:

- Java 21
- Docker Desktop
- Minikube
- kubectl
- Helm

Verify:

```bash
java -version
docker --version
minikube version
kubectl version --client
helm version
```

---

# Quick Start

## Start Minikube

```bash
minikube start
```

## Deploy Development Environment

```bash
./k8s/scripts/deploy.sh dev
```

The deployment script automatically:

- builds Docker image
- switches Docker to Minikube
- creates namespace
- updates ConfigMap
- updates Secret
- deploys Helm Chart
- restarts backend

---

# Access Backend

```bash
kubectl port-forward \
svc/backend-service \
8080:8080 \
-n wedly-dev
```

Open:

http://localhost:8080

Health:

http://localhost:8080/actuator/health

---

# Daily Development

After code changes simply run:

```bash
./k8s/scripts/deploy.sh dev
```

---

# Remove Environment

```bash
./k8s/scripts/undeploy.sh dev
```

---

# Documentation

| Topic | Document |
|--------|----------|
| Local Development | docs/01-local-development.md |
| Kubernetes | docs/02-kubernetes.md |
| Deployment | docs/03-deployment.md |
| Troubleshooting | docs/04-troubleshooting.md |