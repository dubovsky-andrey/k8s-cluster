#!/usr/bin/env bash
set -euo pipefail


PRIMARY=$(kubectl get nodes \
-l node-role.kubernetes.io/control-plane \
-o jsonpath='{.items[0].metadata.name}')

# Get etcdctl version from node
ETCD_VER=$(ssh -o StrictHostKeyChecking=no "$SSH_USER@$PRIMARY" \
    "etcdctl version | head -n1 | awk '{print \$3}'")
echo "→ Remote etcdctl version: $ETCD_VER"
if [[ -z "$ETCD_VER" ]]; then
    echo " Failed to get etcdctl version" >&2
    exit 1
fi

# Defining  runner architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64) PLATFORM="linux-amd64";;
    aarch64|arm64) PLATFORM="linux-arm64";;
    *) echo "Unsupported arch: $ARCH" >&2; exit 1;;
esac

# Download and extract etcdctl
DOWNLOAD_URL="https://github.com/etcd-io/etcd/releases/download/v${ETCD_VER}/etcd-v${ETCD_VER}-${PLATFORM}.tar.gz"
echo "→ Downloading etcdctl from $DOWNLOAD_URL"
curl -sfL "$DOWNLOAD_URL" -o etcd-${ETCD_VER}.tgz
tar -xzf etcd-${ETCD_VER}.tgz -C /tmp
mv /tmp/etcd-v${ETCD_VER}-${PLATFORM}/etcdctl /usr/local/bin/etcdctl
chmod +x /usr/local/bin/etcdctl

echo " etcdctl v${ETCD_VER} installed on runner"