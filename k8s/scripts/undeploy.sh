#!/bin/bash

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./undeploy.sh dev|test|prod"
  exit 1
fi

NAMESPACE="wedly-$ENVIRONMENT"
RELEASE_NAME="wedly-backend"

echo "Removing Helm release..."
helm uninstall "$RELEASE_NAME" -n "$NAMESPACE" || true

echo "Deleting namespace..."
kubectl delete namespace "$NAMESPACE" || true

echo "Done."