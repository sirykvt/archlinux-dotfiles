#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  exit 1
fi

if [ -n "$SUDO_USER" ]; then
    REAL_USER=$SUDO_USER
    REAL_GROUP=$(id -gn $SUDO_USER)
else
    exit 1
fi

DEST="./../system"
mkdir -p $DEST

copy_file() {
    if [ -f "$1" ]; then
        mkdir -p "$DEST$(dirname "$1")"
        cp "$1" "$DEST$1"
        echo "✅ $1 сохранен"
    else
        echo "⚠️ $1 не найден (пропускаем)"
    fi
}

copy_file "/etc/pacman.conf"
copy_file "/etc/mkinitcpio.conf"
copy_file "/etc/locale.gen"
copy_file "/etc/locale.conf"
copy_file "/etc/vconsole.conf"
copy_file "/etc/hostname"
copy_file "/etc/sudoers"
copy_file "/etc/default/grub"
copy_file "/etc/environment"

chown -R "$REAL_USER:$REAL_GROUP" "$DEST"