#!/usr/bin/env zsh

node /home/dev/.config/xchainkeys/make-key-help.js /home/dev/.config/xchainkeys/keys.i3.json > /tmp/help.html
commando-show-image $(commando-html-to-png /tmp/help.html)