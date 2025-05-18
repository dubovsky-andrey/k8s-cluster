#!/usr/bin/env bash

KUBE_PATH = ".kube/config"

# Decode admin kubeconfig from secret
echo "$ADMIN_KUBECONFIG_B64" | base64 -d > $HOME/$KUBE_PATH
chmod 600 $HOME/$KUBE_PATH

# Export for all subsequent steps
echo "KUBECONFIG=$HOME/$KUBE_PATH" >> $GITHUB_ENV