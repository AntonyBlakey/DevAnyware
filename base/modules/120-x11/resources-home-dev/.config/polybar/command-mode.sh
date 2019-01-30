#!/usr/bin/env zsh

# I use the very unexpected system("echo") to make the system yield,
# otherwise consective line are read as a single value by polybar,
# which results in lost output. That was a day I won't get back :(
xchainkeys -d -t 2>/dev/null \
    | gawk \
        -e '/-> F35 :enter/   { print "Command Mode - press ? for help" ; fflush() }' \
        -e '/TRACK exit/    { system("echo") ; fflush() }' \
