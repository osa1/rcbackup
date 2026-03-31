#!/usr/bin/env bash
set -euo pipefail

URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"

# Download, following redirects, and save with the server's actual filename
echo "Downloading VS Code from: $URL"
TARBALL="$(curl --fail --show-error --location --remote-name --remote-header-name --write-out '%{filename_effective}' "$URL")"

echo "Extracting: $TARBALL"
tar --extract --verbose --file "$TARBALL"

echo "Removing: $TARBALL"
rm -- "$TARBALL"

# Fix chrome-sandbox permissions (must be owned by root with SUID bit set)
SANDBOX="VSCode-linux-x64/chrome-sandbox"
echo "Fixing sandbox permissions: $SANDBOX"
sudo chown root:root "$SANDBOX"
sudo chmod 4755 "$SANDBOX"

echo "Done."
