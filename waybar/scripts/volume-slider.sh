#!/usr/bin/env bash
raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
vol=$(echo "$raw" | awk '{print $2}')
pct=$(awk -v v="$vol" 'BEGIN{printf "%d", v*100}')
(( pct > 100 )) && pct=100
filled=$(( pct / 10 ))
empty=$(( 10 - filled ))
bar=""
for ((i=0;i<filled;i++)); do bar+="▮"; done
for ((i=0;i<empty;i++)); do bar+="▯"; done

if echo "$raw" | grep -q MUTED; then
  echo "󰝟 $bar"
else
  echo "󰕾 $bar"
fi
