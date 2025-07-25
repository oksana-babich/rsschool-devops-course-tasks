#!/bin/bash

set -e

NAMESPACE=monitoring

if [ -z "$GRAFANA_USER" ] || [ -z "$GRAFANA_PASS" ]; then
    echo "Error: GRAFANA_USER and GRAFANA_PASS environment variables must be set"
    exit 1
fi

helm repo add bitnami https://charts.bitnami.com/bitnami || true
helm repo update

helm upgrade --install grafana bitnami/grafana \
  --create-namespace \
  --namespace $NAMESPACE \
  --set admin.user="$GRAFANA_USER" \
  --set admin.password="$GRAFANA_PASS" \
  --values monitoring/values-grafana.yaml \
  --wait