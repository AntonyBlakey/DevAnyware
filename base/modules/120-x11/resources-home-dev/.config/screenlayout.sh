#!/usr/bin/env zsh

sleep 0.1

# feh --bg-fill /home/dev/.config/wallpaper/rsmith_single_blade_of_grass.jpg &
feh --randomize --bg-fill /home/dev/.config/wallpaper/*.jpg &

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null ; do sleep 1; done

if type "xrandr" > /dev/null ; then
	for m in $(xrandr --query | grep ' connected' | cut -d " " -f1) ; do
		MONITOR=$m polybar --reload top -c ~/.config/polybar/config &
	done
else
	polybar --reload top -c ~/.config/polybar/config &
fi