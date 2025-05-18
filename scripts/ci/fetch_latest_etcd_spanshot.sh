#!/usr/bin/env bash
set -euo pipefail


PRIMARY=$(kubectl get nodes \
-l node-role.kubernetes.io/control-plane \
-o jsonpath='{.items[0].metadata.name}')

# Find the file on the node
REMOTE_SNAPSHOT=$(ssh -o StrictHostKeyChecking=no "$SSH_USER@$PRIMARY" \
"ls /tmp/etcd-snapshot-*.db | tail -n1")
echo "→ Remote snapshot: $REMOTE_SNAPSHOT"

# Download spapshot
LOCAL_FILE=$(basename "$REMOTE_SNAPSHOT")
ssh -o StrictHostKeyChecking=no "$SSH_USER@$PRIMARY" \
"sudo cat $REMOTE_SNAPSHOT" > "$LOCAL_FILE"
echo "Snapshot downloaded to runner as $LOCAL_FILE"