#!/bin/sh

HOSTNAME=$1
DISK=${2:-/dev/nvme0n1}

if [ -z "$HOSTNAME" ]; then
    echo "Usage: $0 <hostname> [disk_device]"
    echo "Example: $0 my-laptop /dev/sda"
    exit 1
fi

echo "Installing for hostname: $HOSTNAME on disk: $DISK"

sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko#disko-install -- --flake ".#$HOSTNAME" --disk main "$DISK"
