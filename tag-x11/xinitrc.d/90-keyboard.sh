#!/bin/sh
if [ "$DISPLAY" != "" ]; then
  xset r rate 180 80
  setxkbmap -option caps:escape
fi
