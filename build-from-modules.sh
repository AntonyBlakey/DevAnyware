#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

export NAME=$1
shift
export FROM=$1
shift
export DA_MODULES=($*)

echo "Build $NAME from: $FROM with modules: $DA_MODULES"

echo "$NAME build of $(date)" > build.log

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
    echo FROM $FROM
    echo
    echo "ENV DEBIAN_FRONTEND=noninteractive"

    log/start "Install Modules"

    for n in $DA_MODULES ; do 
        m=modules/$n
        if [ -d $m/resources- ] ; then
            log/start "Install $m"
            echo "COPY $m/resources-/ /"
        fi
        if [ -f $m/install.docker ] ; then
            log/start "Install $m"
            cat $m/install.docker
            echo
        fi
    done

    echo
    echo "ENV DEBIAN_FRONTEND=dialog"

) > Dockerfile

docker build -t $NAME . | tee -a build.log