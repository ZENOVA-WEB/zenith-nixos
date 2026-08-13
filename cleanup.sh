#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=================================================="
echo "      Zenith NixOS - Complete System Cleanup"
echo "=================================================="
echo ""

# 1. Clean User Generations and Nix/NH caches
echo "==> 1/6: Deleting user profile generations and Nix evaluation caches..."
nix-collect-garbage -d
rm -rf ~/.cache/nix ~/.cache/nh ~/.cache/nixpkgs-review ~/.cache/fontconfig
rm -rf ~/.cache/micro ~/.cache/cava ~/.cache/lazygit
echo "✓ User generations and user caches purged."
echo ""

# 2. Remove temporary build artifacts & result symlinks
echo "==> 2/6: Removing build symlinks and temporary build directories..."
rm -rf "$SCRIPT_DIR/result" "$SCRIPT_DIR"/result-* ~/result ~/result-* 2>/dev/null || true
rm -rf /tmp/nix-* /tmp/nix-build-* /var/tmp/nix-* 2>/dev/null || true
echo "✓ Build artifacts and temp files cleared."
echo ""

# 3. Clean System-wide Generations & Journal logs (requires sudo)
echo "==> 3/6: Deleting system-wide NixOS generations & vacuuming system logs..."
if [ "$(id -u)" -eq 0 ]; then
    nix-collect-garbage -d
    journalctl --vacuum-time=1d --vacuum-size=50M || true
else
    sudo nix-collect-garbage -d
    sudo journalctl --vacuum-time=1d --vacuum-size=50M || true
fi
echo "✓ System generations & systemd logs purged."
echo ""

# 4. Deep Nix Store Optimization (Hardlink identical binary chunks)
echo "==> 4/6: Optimising /nix/store (hardlinking duplicate files)..."
if [ "$(id -u)" -eq 0 ]; then
    nix-store --optimise
else
    sudo nix-store --optimise
fi
echo "✓ Nix store deduplication complete."
echo ""

# 5. Refresh font cache & system caches
echo "==> 5/6: Refreshing font cache..."
fc-cache -f -v >/dev/null 2>&1 || true
echo "✓ Font cache refreshed."
echo ""

# 6. Update system bootloader entries
echo "==> 6/6: Syncing bootloader menu entries..."
if [ "$(id -u)" -eq 0 ]; then
    /nix/var/nix/profiles/system/bin/switch-to-configuration boot || true
else
    sudo /nix/var/nix/profiles/system/bin/switch-to-configuration boot || true
fi
echo "✓ Bootloader menu entries updated."
echo ""

echo "=================================================="
echo "🎉 Cleanup complete! All unreferenced package files,"
echo "   old generations, and caches have been purged."
echo "=================================================="
