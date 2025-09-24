#!/usr/bin/env bash

# Default to hostname as host if $1 is empty or non-numeric
if [[ -z "$1" || ! "$1" =~ ^[0-9]+$ ]]; then
    HOST=$(hostname)
    CORE_OPTION=""
else
    HOST=$(hostname)
    CORE_OPTION="--option cores $1"
fi

# Run nixos-rebuild with optional core limit
sudo nixos-rebuild --flake .#$HOST switch $CORE_OPTION

