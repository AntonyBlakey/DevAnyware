#!/usr/bin/env zsh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while (ps axo command | grep ^polybar) >/dev/null; do sleep 1; done

export MONITOR=$(xrandr --query | grep " connected" | cut -d" " -f1)
cmd=(polybar --reload top)

if [[ $# -gt 0 ]] && [[ $1 = "block" ]]; then
	exec "${cmd[@]}"
else
	"${cmd[@]}" &
fi
