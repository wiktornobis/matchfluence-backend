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
kubectl get pods -n wedly-dev

kubectl get svc -n wedly-dev
```

## Backend

```bash
kubectl port-forward \
svc/backend-service \
8080:8080 \
-n wedly-dev
```

## PostgreSQL

```bash
kubectl port-forward \
svc/postgres-service \
5432:5432 \
-n wedly-dev
```

## Elasticsearch

```bash
kubectl port-forward \
svc/elasticsearch-service \
9200:9200 \
-n wedly-dev
```