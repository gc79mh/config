#!/usr/bin/env bash

# — configure these paths:
BG="/home/user/.config/hypr/bg"       # your base photo
TODO="/todo.md"               # the file you edit
OUT="/tmp/hypr-todo-wall.png"           # generated wallpaper
MONITOR="eDP-1"                             # replace with your monitor name

magick "$BG" \
  -gravity southwest \
  -font "JetBrainsMono-NF-Regular" -pointsize 32 -fill white \
  -annotate +200+0 "$(cat $TODO)" \
  "$OUT"

hyprctl hyprpaper unload all
hyprctl hyprpaper preload /tmp/hypr-todo-wall.png
hyprctl hyprpaper wallpaper "eDP-1,/tmp/hypr-todo-wall.png"

