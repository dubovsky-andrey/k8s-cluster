#!/usr/bin/env bash
set -euo pipefail

K_VER=$(curl -sSL https://dl.k8s.io/release/stable.txt)
curl -sSL "https://dl.k8s.io/release/${K_VER}/bin/linux/${YQ_ARCH}/kubectl" -o /tmp/kubectl
install -m 0755 /tmp/kubectl /usr/local/bin/kubectl