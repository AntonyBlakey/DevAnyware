#!/usr/bin/env zsh

# Windows sdks are normally used on a case-insensitive file system
# and as a result the case of the file sometimes doesn't match it's use.
# Therefore I link all files to their lowercase equivalents where they don't
# already exist.
#
# There are also a few special case of the reverse transform, which I add as
# I run into them.

for arch in x86 x64 ; do
    cd /windows/sdk/Lib/10.0.17763.0/um/${arch}
    for i in * ; do 
        if [ ! -e $i:l ] ; then
            ln -s $i $i:l
        fi
    done
done

for dir in um shared ; do 
    cd /windows/sdk/Include/10.0.17763.0/${dir}
    for i in * ; do
        if [ ! -e $i:l ] ; then 
            ln -s $i $i:l
        fi
    done
done

ln -s /windows/sdk/Include/10.0.17763.0/shared/driverspecs.h /windows/sdk/Include/10.0.17763.0/shared/DriverSpecs.h
ln -s /windows/sdk/Include/10.0.17763.0/shared/specstrings.h /windows/sdk/Include/10.0.17763.0/shared/SpecStrings.h
ln -s /windows/sdk/Include/10.0.17763.0/um/usp10.h /windows/sdk/Include/10.0.17763.0/um/Usp10.h
