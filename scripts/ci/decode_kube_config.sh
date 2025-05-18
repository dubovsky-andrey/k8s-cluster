#!/usr/bin/env bash
set -euo pipefail

# where in $HOME we want to drop the file
KUBE_PATH=".kube/config"

# make sure the directory exists
mkdir -p "$HOME/$(dirname "$KUBE_PATH")"

# Decode admin kubeconfig from secret
echo "$ADMIN_KUBECONFIG_B64" | base64 -d > "$HOME/$KUBE_PATH"
chmod 600 "$HOME/$KUBE_PATH"

# Export for all subsequent steps
echo "KUBECONFIG=$HOME/$KUBE_PATH" >> "$GITHUB_ENV"
