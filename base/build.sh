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

(
    cat prelude.docker
    echo

    log/start "Install Modules"
    echo "USER root"

    for m in modules/*(/) ; do 
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

    for m in modules/*(/) ; do 
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