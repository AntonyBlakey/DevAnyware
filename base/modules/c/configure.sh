#!/usr/bin/env zsh

code --install-extension ms-vscode.cpptools
code --install-extension ccls-project.ccls
code --install-extension twxs.cmake 

TEMP=$(mktemp)
SETTINGS='/home/dev/.config/Code/User/settings.json'
cp $SETTINGS $TEMP
cat <<EOF | jq -s '.[0] * .[1]' - $TEMP > $SETTINGS
{
    "ccls.highlighting.enabled.types": true,
    "ccls.highlighting.enabled.freeStandingFunctions": true,
    "ccls.highlighting.enabled.memberFunctions": true,
    "ccls.highlighting.enabled.freeStandingVariables": true,
    "ccls.highlighting.enabled.memberVariables": true,
    "ccls.highlighting.enabled.namespaces": true,
    "ccls.highlighting.enabled.macros": true,
    "ccls.highlighting.enabled.enums": true,
    "ccls.highlighting.enabled.typeAliases": true,
    "ccls.highlighting.enabled.enumConstants": true,
    "ccls.highlighting.enabled.staticMemberFunctions": true,
    "ccls.highlighting.enabled.parameters": true,
    "ccls.highlighting.enabled.templateParameters": true,
    "ccls.highlighting.enabled.staticMemberVariables": true,
    "ccls.highlighting.enabled.globalVariables": true,
    "C_Cpp.clang_format_fallbackStyle": "{ BasedOnStyle: Chromium, ColumnLimit: 140 }",
    "C_Cpp.clang_format_sortIncludes": false,
    "C_Cpp.autocomplete": "Disabled",
    "C_Cpp.formatting": "Disabled",
    "C_Cpp.errorSquiggles": "Disabled",
    "C_Cpp.intelliSenseEngine": "Disabled"
}
EOF
rm $TEMP