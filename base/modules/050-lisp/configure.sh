#!/usr/bin/env zsh

code-insiders --install-extension cospaia.clojure4vscode

# TEMP=$(mktemp)
# SETTINGS='/home/dev/.config/Code - Insiders/User/settings.json'
# cp $SETTINGS $TEMP
# cat <<EOF | jq -s '.[0] * .[1]' - $TEMP > $SETTINGS
# {
#     "parinfer.defaultMode": "disabled",
#     "calva.autoAdjustIndent": true,
#     "calva.lintOnSave": false
# }
# EOF
# rm $TEMP

clojure < /dev/null
lein