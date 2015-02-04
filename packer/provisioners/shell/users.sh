#!/usr/bin/env sh

NEW_USER=""
NEW_HOME="/home/$NEW_USER"

SSH_KEY=""
SSH_DIR="$NEW_HOME/.ssh/"
SSH_AUTHORIZED_KEYS="$SSH_DIR/.authorized_keys"

if [ -z "$(getent passwd $NEW_USER)" ]; then
    useradd --groups sudo --shell /bin/bash --create-home "$NEW_USER"
fi

if [ ! -d "$SSH_DIR" ]; then
    mkdir "$SSH_DIR";
fi

if [ ! -f "$SSH_AUTHORIZED_KEYS" ]; then
    touch "$NEW_HOME/.ssh/authorized_keys";
fi

echo "$SSH_KEY" >> "$NEW_HOME/.ssh/authorized_keys"
