#!/bin/bash

SOCKET="$HOME/nockchain/.socket/nockchain_npc.sock"

read -p "Enter pubkey: " PUBKEY

if [[ ! "$PUBKEY" =~ ^[a-zA-Z0-9]+$ ]]; then
  echo "Invalid pubkey format."
  exit 1
fi

CSV_FILE="notes-${PUBKEY}.csv"

if [[ ! -f "$CSV_FILE" ]]; then
  echo "CSV file not found. Generating..."
  nockchain-wallet --nockchain-socket "$SOCKET" list-notes-by-pubkey-csv "$PUBKEY"
  sleep 1

  if [[ ! -f "$CSV_FILE" ]]; then
    echo "Failed to generate CSV file for pubkey."
    exit 1
  fi
fi

echo "Using CSV file: $CSV_FILE"

TOTAL_NICKS=$(tr -d '\000' < "$CSV_FILE" | awk -F',' '
  NR > 1 && $3 ~ /^[0-9]+$/ { sum += $3 }
  END { print sum }
')

if [[ -z "$TOTAL_NICKS" || "$TOTAL_NICKS" == "0" ]]; then
  echo "ℹ️  No assets found for pubkey."
  exit 0
fi

DECIMAL_NOCKS=$(awk -v t="$TOTAL_NICKS" 'BEGIN { printf "%.4f", t/65536 }')

echo "Balance for pubkey: $PUBKEY"
echo "  $TOTAL_NICKS Nicks"
echo "  ≈ $DECIMAL_NOCKS Nocks (decimal)"
