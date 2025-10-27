#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <USERNAME> <WRAPPER>"
    exit 1
fi

USERNAME="$1"
WRAPPER="$2"
USER_HOME="/home/$USERNAME"
RESTRICTED_BIN="$USER_HOME/bin"

# Deploy a wrapper
echo "[+] Creating wrapper script..."
sudo cp -p "wrappers/$WRAPPER" "$RESTRICTED_BIN/$WRAPPER"

sudo chmod +x "$RESTRICTED_BIN/$WRAPPER"
sudo chown "$USERNAME:$USERNAME" "$RESTRICTED_BIN/$WRAPPER"

echo "Deploy wrapper $WRAPPER complete!"