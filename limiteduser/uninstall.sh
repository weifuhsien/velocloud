#!/bin/bash

set -e

read -p "Enter username: " USERNAME

USER_HOME="/home/$USERNAME"
SUDOERS_FILE="/etc/sudoers.d/$USERNAME"

sudo deluser --remove-home "$USER_HOME" "$USERNAME"
sudo rm "$SUDOERS_FILE"

