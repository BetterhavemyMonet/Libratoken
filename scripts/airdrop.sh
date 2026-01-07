#!/usr/bin/env bash
MINT_ADDRESS="BYqHJvvtJSgXQi9iuL6PcXmVNADqBDxNGkyAhY8zwTWR"
SITE_DIR="./site"
DRY_RUN=true
WALLETS_FILE="$SITE_DIR/wallets.json"
echo "=== Libra Airdrop Script (Dry Run) ==="
if [ ! -f "$WALLETS_FILE" ]; then echo "Wallets file missing, creating empty array"; echo "[]" > "$WALLETS_FILE"; fi
WALLETS=$(jq -r '.[]' "$WALLETS_FILE")
TOTAL=$(echo "$WALLETS" | wc -l)
echo "Found $TOTAL wallets"
echo "Dry run wallets (first 5):"; echo "$WALLETS" | head -n 5
