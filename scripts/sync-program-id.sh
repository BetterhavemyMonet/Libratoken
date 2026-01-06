#!/bin/bash
set -e

# Path to program keypair (change if your program name or path is different)
KEYPAIR=target/deploy/libra-keypair.json

# Extract program ID from keypair file
if [[ ! -f "$KEYPAIR" ]]; then
  echo "Keypair file not found: $KEYPAIR"
  exit 1
fi

PROGRAM_ID=$(solana address -k "$KEYPAIR")
if [[ -z "$PROGRAM_ID" ]]; then
  echo "Failed to extract program ID."
  exit 1
fi

echo "Program ID: $PROGRAM_ID"

# Update Anchor.toml
ANCHOR_TOML="Anchor.toml"
sed -i.bak "s/^libra = \".*\"/libra = \"$PROGRAM_ID\"/" "$ANCHOR_TOML"
echo "Updated $ANCHOR_TOML"

# Update Rust declare_id macro
LIB_RS="programs/libra/src/lib.rs"
sed -i.bak "s/^declare_id!(\".*\");/declare_id!(\"$PROGRAM_ID\");/" "$LIB_RS"
echo "Updated $LIB_RS"