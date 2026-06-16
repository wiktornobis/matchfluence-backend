# Local Development

## Start Minikube

```bash
minikube start
```

## Deploy

```bash
./k8s/scripts/deploy.sh dev
```

## Verify

```bash
kubectl get pods -n matchfluence-dev

kubectl get svc -n matchfluence-dev
```

## Backend

```bash
kubectl port-forward \
svc/backend-service \
8080:8080 \
-n matchfluence-dev
```

## PostgreSQL

```bash
kubectl port-forward \
svc/postgres-service \
5432:5432 \
-n matchfluence-dev
```

## Elasticsearch

```bash
kubectl port-forward \
svc/elasticsearch-service \
9200:9200 \
-n matchfluence-dev
```