#!/usr/bin/env zsh

POSITION=$2
HTMLFILE=$1
CACHEDIR=/home/dev/.cache/commando/images
PNGFILE=$CACHEDIR/$(md5sum $HTMLFILE | cut -d ' ' -f 1).png

if [ ! -f $PNGFILE ] ; then
    mkdir -p $CACHEDIR
    chromium-browser --headless --screenshot=/tmp/commando.screenshot.png --window-size=2560x1440 $HTMLFILE
    convert /tmp/commando.screenshot.png -trim -shave 1x1 $PNGFILE
fi


read WIDTH HEIGHT < <(identify -format "%w %h" $PNGFILE)
xdotool search --name "Commando - Help" windowkill 2>/dev/null
if [[ $POSITION == "0" ]] ; then
    feh --title "Commando - Help" --geometry $HEIGHTx$WIDTH+$(( (2560 - $WIDTH) >> 1 ))+20 $PNGFILE 2>/dev/null &
else
    feh --title "Commando - Help" --geometry $HEIGHTx$WIDTH+$(( (2560 - $WIDTH) >> 1 ))+$(( 1440 - $HEIGHT - 4 )) $PNGFILE 2>/dev/null &
fi
