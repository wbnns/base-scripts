#!/bin/bash

read -p "Enter the Base address: " BASE_ADDRESS

RPC_ENDPOINT="https://goerli.base.org"

# Make the RPC call to get the transaction count
response=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "id": 0,
    "jsonrpc": "2.0",
    "method": "eth_getTransactionCount",
    "params": ["'"$BASE_ADDRESS"'", "latest"]
  }' \
  "$RPC_ENDPOINT"
)

# Check if the response contains an error message
error=$(echo "$response" | jq -r '.error')
if [ "$error" != "null" ]; then
  echo "Error: $error"
else
  # Extract the transaction count from the response using jq
  transaction_count=$(echo "$response" | jq -r '.result')

  echo "Total transactions for address $BASE_ADDRESS: $transaction_count"
fi

