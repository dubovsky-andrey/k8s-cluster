#!/usr/bin/env bash
set -euo pipefail

NEED=0
while read -r NODE; do
CURRENT=$(kubectl get node "$NODE" -o jsonpath='{.status.nodeInfo.kubeletVersion}')
printf "Node %-20s : current=%s desired=%s\n" "$NODE" "$CURRENT" "$DESIRED"
if [ "$CURRENT" != "$DESIRED" ]; then
    echo "::warning ::$NODE requires upgrade to $DESIRED"
    NEED=1
fi
done < /tmp/nodes.lst
echo "need_upgrade=$NEED" >> $GITHUB_OUTPUT