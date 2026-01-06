#!/bin/bash
set -e

echo "🔄 Updating system..."
sudo apt-get update -y && sudo apt-get upgrade -y

echo "📦 Installing dependencies..."
sudo apt-get install -y curl wget git build-essential pkg-config libssl-dev

echo "📥 Installing Rust (for SPL CLI & builds)..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

echo "📥 Installing Solana CLI..."
sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
echo 'export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"' >> ~/.bashrc
solana --version

echo "📥 Installing SPL Token CLI..."
cargo install spl-token-cli
spl-token --version

echo "📥 Installing Metaplex Token Metadata CLI..."
wget https://github.com/metaplex-foundation/mpl-token-metadata/releases/latest/download/mpl-token-metadata-x86_64-unknown-linux-gnu.tar.gz -O mpl.tar.gz
tar -xvzf mpl.tar.gz
chmod +x mpl-token-metadata
mv mpl-token-metadata ~/.cargo/bin/
mpl-token-metadata --help

echo "🌐 Configuring Solana mainnet..."
solana config set --url https://api.mainnet-beta.solana.com

echo "💳 Creating a new wallet..."
solana-keygen new --outfile ~/my-wallet.json --force
solana config set --keypair ~/my-wallet.json
echo "👉 Wallet address:"
solana address

echo "⚠️ Please fund this wallet with some SOL before proceeding."
echo "⏳ Waiting 20 seconds..."
sleep 20

MINT_ADDRESS="7GW48dX4puK3kbnqj3ru2fWHfJgaVJxQsJHPYBoN9SJY"

echo "📂 Creating Libra token account..."
spl-token create-account $MINT_ADDRESS

echo "🪙 Minting Libra tokens..."
spl-token mint $MINT_ADDRESS