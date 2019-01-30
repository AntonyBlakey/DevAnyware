#!/usr/bin/env zsh

DIR=/home/dev/.config/xchainkeys
cat $DIR/help-*.txt > $DIR/help.txt
lxterminal \
    --command="zsh -c 'cat $DIR/help.txt && sleep 600'" \
    --title='i3 command mode help' \
    --geometry=$(wc -L -l $DIR/help.txt | awk '{ print $2"x"($1+1) }')