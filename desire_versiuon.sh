#!/usr/bin/env bash
set -euo pipefail

DESIRED=$(yq '.desiredVersion' configs/k8s-config.yaml)
SELECTOR=$(yq -r '.labelSelector // ""' configs/k8s-config.yaml)
echo "desired=$DESIRED" >> "$GITHUB_OUTPUT"
echo "selector=$SELECTOR" >> "$GITHUB_OUTPUT"