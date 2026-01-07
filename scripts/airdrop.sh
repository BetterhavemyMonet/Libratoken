#!/data/data/com.termux/files/usr/bin/bash
WALLET="$1"
DRY_RUN=true   # Set false for real airdrop
CLAIM_FILE="scripts/claimed.txt"
mkdir -p scripts
touch "$CLAIM_FILE"
if grep -qx "$WALLET" "$CLAIM_FILE"; then
  echo "❌ Wallet $WALLET has already claimed the airdrop."
  exit 0
fi
if [ "$DRY_RUN" = true ]; then
  echo "🧪 Dry run: 100,000 tokens would be sent to $WALLET."
else
  echo "Sending 100,000 tokens to $WALLET..."
  # Insert your real Solana transfer command here
fi
echo "$WALLET" >> "$CLAIM_FILE"
echo "✅ Wallet $WALLET marked as claimed."
