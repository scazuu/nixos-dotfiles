#!/usr/bin/env bash
WALLPAPER_DIR="/home/scazuu/Pictures/Wallpapers"

selected=$(for img in "$WALLPAPER_DIR"/*; do
  echo -en "img:$img:text:$img\n"
done | wofi --dmenu -p "Wallpaper" --allow-images)

wallpaper="${selected##*text:}"

[ -n "$wallpaper" ] && awww img "$wallpaper" --transition-type random --transition-duration 1 --transition-fps 140
