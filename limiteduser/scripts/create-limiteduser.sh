#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <USERNAME>"
    exit 1
fi

USERNAME="$1"
USER_HOME="/home/$USERNAME"
RESTRICTED_BIN="$USER_HOME/bin"

echo "[+] Checking a limited user $USERNAME status"
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists."
    exit 1
fi

echo "[+] Creating a limited user restricted: $USERNAME"
sudo mkdir -p "$USER_HOME"
sudo adduser -h "$USER_HOME" -s /bin/rbash "$USERNAME"
# Note: adduser prompts the user to enter the PASSWORD.

echo "[+] Creating restricted bin at $RESTRICTED_BIN..."
sudo mkdir -p "$RESTRICTED_BIN"
sudo chown "$USERNAME:$USERNAME" "$RESTRICTED_BIN"

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

echo "[+] Adding basic commands in $RESTRICTED_BIN..."
cd $RESTRICTED_BIN
ln -s /bin/cat
ln -s /bin/date
ln -s /bin/grep
ln -s /bin/ls
ln -s /usr/bin/awk
ln -s /usr/bin/cut
ln -s /usr/bin/ifstat
ln -s /usr/bin/top
ln -s /usr/bin/uptime
ln -s /usr/bin/whoami
ln -s /usr/sbin/tcpdump
ln -s /opt/vc/sbin/edged

echo "Create a limiteduser $USERNAME complete!"