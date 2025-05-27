#!/bin/bash

set -e

read -p "Enter username: " USERNAME

USER_HOME="/home/$USERNAME"
RESTRICTED_BIN="$USER_HOME/bin"
DEBUG_SCRIPT="/opt/vc/sbin/debug.py"
WRAPPER="$RESTRICTED_BIN/debugpy"

# Create a limited user
./scripts/create-limiteduser.sh "$USERNAME"

# Create a wrapper script
./scripts/create-wrapper-script.sh "$USERNAME" "$WRAPPER" 

# Finish
echo ""
echo "Setup complete!"
echo "User: $USERNAME"
echo "Only allowed command: debugpy (which runs 'sudo $DEBUG_SCRIPT')"
echo "Try: su - $USERNAME, then run: debugpy --health"