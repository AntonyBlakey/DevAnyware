#!/usr/bin/env zsh

curl -s -O --insecure http://files.soops.intern/Software/Windows/sdk/MSVC.14.16.27023.zip
unzip -q *.zip
rm *.zip
mv MSVC /windows/msvc

curl -s -O --insecure http://files.soops.intern/Software/Windows/sdk/WindowsSDK.10.0.17763.0.zip
unzip -q *.zip
rm *.zip
mv WindowsSDK /windows/sdk