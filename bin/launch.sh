#!/bin/bash

killall -9 waybar
killall -9 swaync
waybar &
swaync &
hyprctl reload &
./walset.sh /home/annguyen/Pictures/Wallpapers/dark 900
