#!/usr/bin/env bash
set -euo pipefail

if [ -n "$SEL" ]; then
kubectl get nodes -l "$SEL" -o json > nodes.json
else
kubectl get nodes -o json > nodes.json
fi
jq -r '.items[].metadata.name' nodes.json > /tmp/nodes.lst
echo "count=$(wc -l < /tmp/nodes.lst)" >> $GITHUB_OUTPUT