#!/usr/bin/env bash
set -euo pipefail


PRIMARY=$(kubectl get nodes \
-l node-role.kubernetes.io/control-plane \
-o jsonpath='{.items[0].metadata.name}')