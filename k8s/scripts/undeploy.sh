#!/bin/bash

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./undeploy.sh dev|test|prod"
  exit 1
fi

NAMESPACE="matchfluence-$ENVIRONMENT"
RELEASE_NAME="matchfluence-backend"

echo "Removing Helm release..."
helm uninstall "$RELEASE_NAME" -n "$NAMESPACE" || true

echo "Deleting namespace..."
kubectl delete namespace "$NAMESPACE" || true

echo "Done."