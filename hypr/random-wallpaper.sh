#!/usr/bin/env bash

pkill hyprpaper

hyprpaper &

sleep 2

WALLPAPER_DIR="$HOME/.config/wallpapers/2025"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
WALLPAPER=$(realpath $WALLPAPER)
echo $WALLPAPER

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
