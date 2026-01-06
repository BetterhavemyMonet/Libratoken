# Libra Token (Solana - Anchor)

Libra Token is a starter Solana program + SPL token scaffold using the Anchor framework.

## Contents
- `programs/libra/` — Anchor/Rust program
- `scripts/deploy.sh` — build & deploy helper
- `tests/` — basic TypeScript test using Anchor
- `Anchor.toml`, `Cargo.toml` — Anchor & workspace config

## Quick start (localnet)
1. Install Anchor, Rust, Solana CLI, Node.js, and Yarn/NPM.
2. Clone or unzip this repo.
3. Install JS deps:
   ```bash
   cd libra-token
   npm install
   ```
4. Build & deploy:
   ```bash
   anchor build
   anchor deploy
   ```
5. Run tests:
   ```bash
   npm test
   ```

## Notes
- Replace `YourProgramIDHere...` in `programs/libra/src/lib.rs` and `Anchor.toml` with your real program ID after `anchor build`/`address` generation.
- This scaffold is a starting point — add minting, metadata, and token logic as needed.
