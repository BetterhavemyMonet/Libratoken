#!/bin/bash
set -e

echo "🚀 Building Libra Token program..."
anchor build

echo "📡 Deploying Libra Token program..."
anchor deploy

echo "✅ Deployment finished!"
