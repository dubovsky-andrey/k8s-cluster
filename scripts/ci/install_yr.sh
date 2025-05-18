#!/usr/bin/env bash
set -euo pipefail

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  RUNNER_ARCH_ARCH="amd64"
else
  RUNNER_ARCH="arm64"
fi

URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${RUNNER_ARCH}"

curl -fsSL "$URL" -o /tmp/yq
install -m 0755 /tmp/yq /usr/local/bin/yq
echo "YQ version"
yq --version