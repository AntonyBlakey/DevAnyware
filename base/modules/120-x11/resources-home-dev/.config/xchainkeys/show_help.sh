#!/usr/bin/env zsh

DIR=/home/dev/.config/xchainkeys
cat $DIR/help-*.txt > $DIR/help.txt
st -t 'i3 command mode help' -g $(wc -L -l $DIR/help.txt | awk '{ print $2"x"($1+1) }') -e zsh -c "cat $DIR/help.txt && sleep 600"