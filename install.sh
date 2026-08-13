#!/usr/bin/env bash
set -e

# Handle Ctrl+C (SIGINT) cleanly
trap 'echo -e "\n\n⚠️  Installation aborted by user (Ctrl+C). Exiting cleanly..."; exit 1' INT

echo "=================================================="
echo "   Zenith NixOS Installer Script"
echo "   (Press Ctrl + C at any time to force quit)"
echo "=================================================="
echo ""

# Safety Check 1: Auto-detect active non-root username
REAL_USER="${SUDO_USER:-$USER}"
if [ -n "$REAL_USER" ] && [ "$REAL_USER" != "root" ]; then
    echo "==> Auto-detecting active user: $REAL_USER"
    sed -i "s/user = \".*\";/user = \"$REAL_USER\";/g" vars.nix 2>/dev/null || true
fi

# Safety Check 2: Auto-import current system hardware configuration if available
HW_TARGET="hosts/desktop/hardware-configuration.nix"
if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
    echo "==> Auto-detecting local hardware configuration from /etc/nixos/..."
    mkdir -p hosts/desktop
    cp /etc/nixos/hardware-configuration.nix "$HW_TARGET"
    echo "✓ Local hardware configuration synced successfully."
elif [ ! -f "$HW_TARGET" ]; then
    echo "==> Generating local hardware configuration..."
    mkdir -p hosts/desktop
    sudo nixos-generate-config --show-hardware-config > "$HW_TARGET"
    echo "✓ Hardware configuration generated."
fi

./install.py

read -p "Do you want to run nixos-rebuild switch now? (y/N): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    if [ "$(id -u)" -eq 0 ]; then
        nixos-rebuild switch --flake .#desktop
    else
        sudo nixos-rebuild switch --flake .#desktop
    fi
fi
