#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <USERNAME> <USER_HOME> <RESTRICTED_BIN>"
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

echo "[+] Adding basic commands in $RESTRICTED_BIN..."
cd $RESTRICTED_BIN
ln -s /bin/cat
ln -s /bin/date
ln -s /bin/grep
ln -s /bin/ls
ln -s /usr/bin/top
ln -s /usr/bin/uptime
