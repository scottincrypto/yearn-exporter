#! /bin/bash
set -e

NETWORK="mainnet-custom" # default to Mainnet (Infura)
#EXPLORER=${EXPLORER:-https://api.etherscan.io/api}
EXPLORER=https://cache.yearn.science/etherscan/api
WEB3_PROVIDER=https://eth-mainnet.alchemyapi.io/v2/JtI6A7s6TZjxH8ypRibeDr0dCh89Elta

if [[ ! -z "$WEB3_PROVIDER" ]]; then
  NETWORK="mainnet-custom"

  if [[ ! $(brownie networks list | grep mainnet-custom) ]]; then
    brownie networks add Ethereum $NETWORK host=$WEB3_PROVIDER chainid=1 explorer=$EXPLORER
  else
    brownie networks modify $NETWORK host=$WEB3_PROVIDER chainid=1 explorer=$EXPLORER
  fi
fi

if [[ $# -eq 0 ]]; then
  echo "please provide a function to run as first arg."
  exit 1
fi

echo "Running brownie for $@ on network $NETWORK..."
brownie run $@ --network $NETWORK
