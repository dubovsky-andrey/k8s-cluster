#!/usr/bin/env bash

YQ_VER="v4.44.1"
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  YQ_ARCH="amd64"
else
  YQ_ARCH="arm64"
fi
curl -L "https://github.com/mikefarah/yq/releases/download/${YQ_VER}/yq_linux_${YQ_ARCH}" -o /tmp/yq
sudo install -m 0755 /tmp/yq /usr/local/bin/yq