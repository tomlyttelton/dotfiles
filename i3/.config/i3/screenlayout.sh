#!/usr/bin/env bash

resolutions=(
  "--output HDMI-0 --mode 2560x1440 --pos 1440x560 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off --output HDMI-1 --mode 2560x1440 --pos 0x0 --rotate left --output DP-1-1 --off --output DP-1-2 --off --output HDMI-1-1 --off --output DP-1-3 --off",
)

for resolution in "${resolutions[@]}"; do
  xrandr --dryrun $resolution > /dev/null 2>&1
  if [ $? -eq 0 ]; then
  	xrandr $resolution
  	break
  fi
done
