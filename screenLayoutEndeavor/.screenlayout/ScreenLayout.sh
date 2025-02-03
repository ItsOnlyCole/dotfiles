#!/bin/sh
xrandr --output HDMI-0 --mode 2560x1600 --pos 5360x120 --rotate normal --output DP-0 --primary --mode 3440x1440 --pos 1920x0 --rotate normal --rate 144 --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 0x180 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off

#Waits 2 seconds for screen to adjust then pushes notification
sleep 2s
dunstify "Screen Layout" "Ultrawide Layout"
