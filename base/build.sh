#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

# Have to do this because git ignores empty dirs
[ -d resources-home-dev/work ] || mkdir resources-home-dev/work

name=$(basename $(pwd))

echo "$name build of $(date)" > build.log

export LAST_LOG="none"

log/start() {
    if [[ $LAST_LOG != $1 ]] ; then
        LAST_LOG=$1
        echo
        echo '######### '$1
        echo
    fi
}

# modules is already used in zsh
da_modules=(     \
    "c"          \
    "python"     \
    "conan"      \
    "javascript" \
    "reason"     \
    "rust"       \
    "x11"        \
    "commando"   \
    "qtile"      \
    "st"         \
    "neovim"     \
    "vscode"     \
)

(
    cat prelude.docker
    echo

    log/start "Install Modules"
    echo "USER root"

    for n in $da_modules ; do 
        m=modules/$n
        if [ -d $m/resources- ] ; then
            log/start "Install $m"
            echo "COPY $m/resources-/ /"
        fi
        if [ -d $m/resources-home-dev ] ; then
            log/start "Install $m"
            echo "COPY --chown=dev:dev $m/resources-home-dev/ /home/dev/"
        fi
        if [ -f $m/install.docker ] ; then
            log/start "Install $m"
            cat $m/install.docker
            echo
        fi
    done

    log/start "Configure Modules"
    echo "USER dev"

    for n in $da_modules ; do 
        m=modules/$n
        if [ -f $m/configure.sh ] ; then
            log/start "Configure $m"
            echo "COPY --chown=dev:dev $m/configure.sh configure.sh"
            echo 'RUN source configure.sh && rm configure.sh'
        fi
    done

    echo
    cat postlude.docker

) > Dockerfile

docker build -t devanyware/$name . | tee -a build.log