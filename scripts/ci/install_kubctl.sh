#!/usr/bin/env bash
set -euo pipefail

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  RUNNER_ARCH_ARCH="amd64"
else
  RUNNER_ARCH="arm64"
fi

K_VER=$(curl -sSL https://dl.k8s.io/release/stable.txt)
curl -sSL "https://dl.k8s.io/release/${K_VER}/bin/linux/${RUNNER_ARCH}/kubectl" -o /tmp/kubectl
install -m 0755 /tmp/kubectl /usr/local/bin/kubectl