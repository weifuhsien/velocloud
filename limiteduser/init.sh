#!/bin/bash

set -e

read -p "Enter username: " USERNAME

DEBUG_SCRIPT="/opt/vc/sbin/debug.py"

# Create a limited user
./scripts/create-limiteduser.sh "$USERNAME"

# Deploy a wrapper debugpy
WRAPPER="debugpy"
./scripts/deploy-wrappers.sh "$USERNAME" "$WRAPPER" 

# Deploy a wrapper cmdlist
WRAPPER="cmdlist"
./scripts/deploy-wrappers.sh "$USERNAME" "$WRAPPER" 

# Finish
echo ""
echo "Setup complete!"
echo "User: $USERNAME"
echo "Only allowed command: debugpy (which runs 'sudo $DEBUG_SCRIPT')"
echo "Try: Login $USERNAME, then run: debugpy --health"