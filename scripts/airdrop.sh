#!/bin/bash
# Auto airdrop 100 LIBRA per wallet
LIBRA_MINT=BYqHJvvtJSgXQi9iuL6PcXmVNADqBDxNGkyAhY8zwTWR
if [ ! -f wallets.txt ]; then
  echo "Error: wallets.txt not found!"
  exit 1
fi
while read wallet; do
  spl-token transfer "$LIBRA_MINT" 100 "$wallet" --allow-unfunded-recipient --fund-recipient
done < wallets.txt
