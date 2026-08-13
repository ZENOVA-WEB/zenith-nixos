#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VARS_NIX="$SCRIPT_DIR/vars.nix"

if [ ! -f "$VARS_NIX" ]; then
    echo "❌ Error: $VARS_NIX not found!"
    exit 1
fi

echo "=================================================="
echo "    Zenith NixOS - Update User Password Hash"
echo "=================================================="
echo ""

# Prompt for password
read -sp "Enter new password: " PASS1
echo ""
read -sp "Confirm new password: " PASS2
echo ""

if [ -z "$PASS1" ]; then
    echo "❌ Error: Password cannot be empty."
    exit 1
fi

if [ "$PASS1" != "$PASS2" ]; then
    echo "❌ Error: Passwords do not match."
    exit 1
fi

echo "==> Generating SHA-512 password hash..."

HASH=""
if command -v openssl >/dev/null 2>&1; then
    HASH=$(openssl passwd -6 "$PASS1")
elif command -v mkpasswd >/dev/null 2>&1; then
    HASH=$(mkpasswd -m sha-512 "$PASS1")
elif command -v python3 >/dev/null 2>&1; then
    HASH=$(python3 -c "import crypt; print(crypt.crypt('$PASS1', crypt.mksalt(crypt.METHOD_SHA512)))")
fi

if [ -z "$HASH" ]; then
    echo "❌ Error: Failed to generate password hash. Ensure openssl or mkpasswd is installed."
    exit 1
fi

# Update or insert hashedPassword in vars.nix
if grep -q 'hashedPassword\s*=' "$VARS_NIX"; then
    sed -i "s|hashedPassword\s*=\s*\".*\";|hashedPassword = \"$HASH\";|g" "$VARS_NIX"
else
    # Insert before the last closing brace
    sed -i "/^}/i \  hashedPassword = \"$HASH\";" "$VARS_NIX"
fi

echo "✓ Password hash updated in vars.nix!"
echo ""
echo "To apply the new password, rebuild NixOS with:"
echo "  nh os switch"
echo "  # or: sudo nixos-rebuild switch --flake .#desktop"
