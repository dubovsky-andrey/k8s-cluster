#!/usr/bin/env bash
set -euo pipefail

echo "Running apt-get update && upgrade"
apt-get update -y

echo "Package update complete"