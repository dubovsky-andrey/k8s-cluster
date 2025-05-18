#!/usr/bin/env bash
set -euo pipefail

SNAPSHOT=$(ls etcd-snapshot-*.db | head -n1)
echo "→ Verifying $SNAPSHOT"

export ETCDCTL_API=3

# Status
etcdctl snapshot status "$SNAPSHOT" || {
echo " status failed"; exit 1
}

# Restore to local folder /tmp/etcd-verify
rm -rf /tmp/etcd-verify
etcdctl snapshot restore "$SNAPSHOT" \
--data-dir /tmp/etcd-verify \
--name test-etcd \
--initial-cluster test-etcd=http://localhost:2380 \
--initial-cluster-token test-token \
--initial-advertise-peer-urls http://localhost:2380 || {
echo " restore failed"; exit 1
}