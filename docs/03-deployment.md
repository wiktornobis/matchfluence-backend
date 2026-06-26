# Deployment

This document describes how to deploy, update, restart and remove Wedly environments.

---

# Deploy Environment

Use the deployment script to create or update an environment.

| Environment | Command                        |
| ----------- | ------------------------------ |
| Development | `./k8s/scripts/deploy.sh dev`  |
| Test        | `./k8s/scripts/deploy.sh test` |
| Production  | `./k8s/scripts/deploy.sh prod` |

The deployment script automatically:

* builds Docker image
* switches Docker to Minikube
* creates or updates Kubernetes namespace
* creates or updates ConfigMap
* creates or updates Secret
* deploys or upgrades Helm Chart
* restarts backend deployment

---

# Update Backend

After making code changes, simply redeploy the environment.

## Development

```bash
./k8s/scripts/deploy.sh dev
```

## Test

```bash
./k8s/scripts/deploy.sh test
```

## Production

```bash
./k8s/scripts/deploy.sh prod
```

The deployment script automatically rebuilds and redeploys the backend.

---

# Restart Backend

If configuration has changed or a manual restart is required:

## Development

```bash
kubectl rollout restart \
deployment/wedly-backend \
-n wedly-dev
```

## Test

```bash
kubectl rollout restart \
deployment/wedly-backend \
-n wedly-test
```

## Production

```bash
kubectl rollout restart \
deployment/wedly-backend \
-n wedly-prod
```

Check rollout status:

```bash
kubectl rollout status \
deployment/wedly-backend \
-n wedly-dev
```

---

# Remove Environment

Remove all resources for a specific environment.

## Development

```bash
./k8s/scripts/undeploy.sh dev
```

## Test

```bash
./k8s/scripts/undeploy.sh test
```

## Production

```bash
./k8s/scripts/undeploy.sh prod
```

The undeploy script removes:

* Helm release
* Kubernetes namespace
* PostgreSQL
* Elasticsearch
* Backend
* Services
* ConfigMaps
* Secrets
* Persistent Volume Claims associated with the namespace

---

# Verify Deployment

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
