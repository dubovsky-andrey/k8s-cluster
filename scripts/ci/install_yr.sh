#!/usr/bin/env bash

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  YQ_ARCH="amd64"
else
  YQ_ARCH="arm64"
fi

URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_${YQ_ARCH}"

curl -fsSL "$URL" -o /tmp/yq
sudo install -m 0755 /tmp/yq /usr/local/bin/yq
echo "YQ version"
yq --version