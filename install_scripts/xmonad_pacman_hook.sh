#!/bin/bash
set -e

HOOK_DIR="/etc/pacman.d/hooks"
HOOK_FILE="$HOOK_DIR/xmonad-recompile.hook"
HOOK_CONTENT='[Trigger]
Operation = Upgrade
Operation = Install
Type = Package
Target = *

[Action]
Description = Recompiling xmonad config
When = PostTransaction
Exec = /usr/bin/sh -c '\''su - lautarob -c "xmonad --recompile"'\''
'

echo "Creating pacman hook for xmonad recompilation..."

sudo mkdir -p "$HOOK_DIR"
echo "$HOOK_CONTENT" | sudo tee "$HOOK_FILE" > /dev/null
sudo chmod 644 "$HOOK_FILE"

echo "✓ Created $HOOK_FILE"
echo ""
echo "The hook will run 'xmonad --recompile' after every pacman update."
echo "To remove: sudo rm $HOOK_FILE"