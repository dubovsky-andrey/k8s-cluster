#!/usr/bin/env bash
set -euo pipefail

# create ~/.ssh and past secret
mkdir -p ~/.ssh
echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa
ls -la ~/.ssh/