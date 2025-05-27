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

# Create a wrapper
echo "[+] Creating wrapper script..."
sudo cp -p wrappers/debugpy $WRAPPER

sudo chmod +x "$WRAPPER"
sudo chown "$USERNAME:$USERNAME" "$WRAPPER"

# Configure .bash_profile and .bashrc limit PATH
echo "[+] Configuring environment..."
sudo tee "$USER_HOME/.bash_profile" > /dev/null <<EOF
export PATH=$RESTRICTED_BIN
EOF

sudo tee "$USER_HOME/.bashrc" > /dev/null <<EOF
export PATH=$RESTRICTED_BIN
EOF

sudo chown "$USERNAME:$USERNAME" "$USER_HOME/.bash_profile" "$USER_HOME/.bashrc"

echo "[+] Creating sudoers entry..."
SUDOERS_LINE="$USERNAME ALL=(ALL) NOPASSWD: ALL"
SUDOERS_FILE="/etc/sudoers.d/$USERNAME"
echo "$SUDOERS_LINE" | sudo tee "$SUDOERS_FILE" > /dev/null
sudo chmod 440 "$SUDOERS_FILE"

echo "[+] Adding debug commands in $RESTRICTED_BIN..."
cd $RESTRICTED_BIN
ln -s /sbin/ifconfig
ln -s /usr/bin/ifstat
ln -s /usr/bin/vtysh
ln -s /opt/vc/sbin/edged