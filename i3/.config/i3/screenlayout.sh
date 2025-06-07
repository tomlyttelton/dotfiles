#!/usr/bin/env bash

resolutions=(
  "--output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate left --output HDMI-2 --mode 2560x1440 --pos 1440x410 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off"
  "--output DP-3-1 --primary --mode 2560x1440 --pos 0x0 --rotate left --output DP-3-2 --mode 2560x1440 --pos 1440x410 --rotate normal"
)

for resolution in "${resolutions[@]}"; do
  xrandr --dryrun $resolution > /dev/null 2>&1
  if [ $? -eq 0 ]; then
  	xrandr $resolution
  	break
  fi
done
