#!/usr/bin/env bash
set -e

nix-shell -p python3 --run "python3 ./install.py"

read -p "Do you want to run nixos-rebuild switch now? (y/N): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    sudo nixos-rebuild switch --flake .#desktop
fi

