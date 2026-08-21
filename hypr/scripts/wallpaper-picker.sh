#!/usr/bin/env bash
WALLPAPER_DIR="/home/scazuu/Pictures/Wallpapers"

selected=$(for img in "$WALLPAPER_DIR"/*; do
  echo -en "img:$img:text:$img\n"
done | wofi --dmenu -p "Wallpaper" --allow-images)

wallpaper="${selected##*text:}"
types=(left right top bottom wipe wave grow center outer)
transition="${types[$RANDOM % ${#types[@]}]}"
[ -n "$wallpaper" ] && awww img "$wallpaper" --transition-type "$transition" --transition-duration 1 --transition-fps 140
