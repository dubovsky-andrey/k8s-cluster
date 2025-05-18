#!/usr/bin/env bash

# Decode admin kubeconfig from secret
echo "${{ secrets.ADMIN_KUBECONFIG_B64 }}" | base64 -d > $HOME/kubeconfig
chmod 600 $HOME/kubeconfig
# Export for all subsequent steps
echo "KUBECONFIG=$HOME/kubeconfig" >> $GITHUB_ENV