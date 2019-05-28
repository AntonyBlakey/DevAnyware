#!/usr/bin/env zsh

killall -q commando
while pgrep -x commando >/dev/null; do sleep 0.1; done
exec $HOME/.cargo/bin/commando listen $HOME/.config/commando