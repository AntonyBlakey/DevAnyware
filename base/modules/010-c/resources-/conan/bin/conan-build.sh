#!/usr/bin/env zsh

set -o errexit

conan source . -if /tmp/conan/build -sf /tmp/conan/source
conan build . -bf /tmp/conan/build -sf /tmp/conan/source

# Add headers to the compile_commands.json file
compdb -p /tmp/conan/build list > ./compile_commands.json 2> /dev/null

# Convert paths to local paths - this is very heuristic.
vim -es -c '%s/\/tmp\/conan\/source\//.\//g' -c '%s/\/tmp\/conan\/build/.\//g' -c 'wqa' ./compile_commands.json