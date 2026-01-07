#!/bin/bash
set -e

DRY_RUN=true
TOTAL=100000

echo "🧪 Libra Airdrop Script"
echo "Dry run: $DRY_RUN"
echo "Total tokens: $TOTAL"

if [ "$DRY_RUN" = true ]; then
  echo "✅ Dry run successful – no tokens sent."
else
  echo "🚀 Live airdrop would execute here."
fi
