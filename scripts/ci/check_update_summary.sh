#!/usr/bin/env bash
set -euo pipefail

echo "### Kubernetes upgrade report" >> $GITHUB_STEP_SUMMARY
echo "- Nodes checked: $NODES_LIST_COUNT" >> $GITHUB_STEP_SUMMARY
if [ "$NODES_NEED_UPGRADE" = "1" ]; then
echo "-  Upgrade needed = True" >> $GITHUB_STEP_SUMMARY
echo "-  Upgrade needed to $DESIRED" >> $GITHUB_STEP_SUMMARY
else
echo "-  All nodes on version $DESIRED" >> $GITHUB_STEP_SUMMARY
fi