#!/usr/bin/env bash
WS=$1
ACTIVE=$(hyprctl activeworkspace | grep -oP '(?<=ID )\d+')
if [ "$WS" == "$ACTIVE" ]; then
  echo "{\"text\": \"$WS\", \"class\": \"active\"}"
else
  echo "{\"text\": \"$WS\", \"class\": \"inactive\"}"
fi
