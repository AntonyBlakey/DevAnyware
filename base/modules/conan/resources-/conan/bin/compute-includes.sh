#!/usr/bin/env zsh

COMMAND_LINE=$(jq -r "[.[] | select(.file | endswith(\"$1\"))][0] | .command" compile_commands.json)

if [[ $COMMAND_LINE == "null" ]] ; then
  exit 1
fi

COMMAND_OUTPUT="$(${=COMMAND_LINE} -E -v 2>&1)"
COMMAND_LINES=(${(f)COMMAND_OUTPUT})

found=0
for i in $COMMAND_LINES ; do
  if [[ $i =~ "#include .* search starts here:" ]] ; then
    found=1
  elif [[ $i == "End of search list." ]] ; then
    found=0
  elif [[ $found == 1 ]] ; then
    echo ${i# *}
  fi
done