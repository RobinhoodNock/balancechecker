
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
echo

TOTAL_NICKS=0
NOTE_NUM=1

# Use process substitution to keep variables in main shell scope
while IFS=',' read -r name_first name_last assets block_height source_hash; do
  # Skip header line or malformed lines
  if [[ "$name_first" == "name_first" ]]; then
    continue
  fi
  if [[ "$assets" =~ ^[0-9]+$ ]]; then
    NICKS=$assets
    NOCKS=$(awk -v n="$NICKS" 'BEGIN { printf "%.4f", n/65536 }')
    echo "Note $NOTE_NUM: $NICKS Nicks / ≈ $NOCKS Nocks"
    TOTAL_NICKS=$((TOTAL_NICKS + NICKS))
    NOTE_NUM=$((NOTE_NUM + 1))
  fi
done < <(tr -d '\000' < "$CSV_FILE")

if (( TOTAL_NICKS == 0 )); then
  echo "ℹ️  No assets found for pubkey."
  exit 0
fi

TOTAL_NOCKS=$(awk -v t="$TOTAL_NICKS" 'BEGIN { printf "%.4f", t/65536 }')

echo
echo "Total balance for pubkey: $PUBKEY"
echo "  $TOTAL_NICKS Nicks"
echo "  ≈ $TOTAL_NOCKS Nocks (decimal)"
