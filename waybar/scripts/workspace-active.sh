#!/usr/bin/env bash
hyprctl activewindow -j 2>/dev/null | jq -r '.workspace.id // empty' 2>/dev/null || hyprctl activeworkspace -j | jq -r '.id'
