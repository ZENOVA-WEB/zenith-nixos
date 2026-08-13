#!/usr/bin/env bash
set -e

./install.py

read -p "Do you want to run nixos-rebuild switch now? (y/N): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    sudo nixos-rebuild switch --flake .#desktop
fi

