#!/bin/bash

set -e

NAMESPACE=monitoring

kubectl get namespace $NAMESPACE >/dev/null 2>&1 || kubectl create namespace $NAMESPACE

helm repo add bitnami https://charts.bitnami.com/bitnami || true
helm repo update

helm upgrade --install grafana bitnami/grafana \
  --namespace $NAMESPACE \
  --values monitoring/values-grafana.yaml \
  --wait
