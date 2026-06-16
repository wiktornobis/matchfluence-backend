#!/bin/bash

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./deploy.sh dev|test|prod"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
K8S_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(dirname "$K8S_DIR")"

NAMESPACE="matchfluence-$ENVIRONMENT"
RELEASE_NAME="matchfluence-backend"

CONFIG_FILE="$K8S_DIR/env/config-$ENVIRONMENT.env"
SECRET_FILE="$K8S_DIR/env/secret-$ENVIRONMENT.env"
VALUES_FILE="$K8S_DIR/helm/matchfluence-backend/values-$ENVIRONMENT.yaml"
CHART_DIR="$K8S_DIR/helm/matchfluence-backend"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Missing config file: $CONFIG_FILE"
  exit 1
fi

if [ ! -f "$SECRET_FILE" ]; then
  echo "Missing secret file: $SECRET_FILE"
  exit 1
fi

if [ ! -f "$VALUES_FILE" ]; then
  echo "Missing values file: $VALUES_FILE"
  exit 1
fi

echo "Environment: $ENVIRONMENT"
echo "Namespace:   $NAMESPACE"

echo "Building Docker image in Minikube Docker..."
eval "$(minikube docker-env)"
docker build -t matchfluence-backend:latest "$PROJECT_DIR"

echo "Creating namespace..."
kubectl create namespace "$NAMESPACE" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "Applying ConfigMap..."
kubectl create configmap matchfluence-config \
  --from-env-file="$CONFIG_FILE" \
  -n "$NAMESPACE" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "Applying Secret..."
kubectl create secret generic matchfluence-secret \
  --from-env-file="$SECRET_FILE" \
  -n "$NAMESPACE" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "Deploying Helm chart..."
helm upgrade --install "$RELEASE_NAME" "$CHART_DIR" \
  -f "$VALUES_FILE" \
  -n "$NAMESPACE"

echo "Restarting backend..."
kubectl rollout restart deployment/matchfluence-backend -n "$NAMESPACE" || true

echo "Done."
kubectl get pods -n "$NAMESPACE"