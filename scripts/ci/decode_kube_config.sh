#!/usr/bin/env bash

# Decode admin kubeconfig from secret
echo "$ADMIN_KUBECONFIG_B64" | base64 -d > "$HOME/.kube/config"
chmod 600 "$HOME/.kube/config"
# Export for all subsequent steps
echo "KUBECONFIG=$HOME/kubeconfig" >> $GITHUB_ENV