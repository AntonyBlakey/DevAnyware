#!/usr/bin/env zsh

set +o errexit ; set +o pipefail

export NAME=$1
shift
export FROM=$1
shift
export DA_MODULES=($*)

echo "Build $NAME from: $FROM with modules: $DA_MODULES"

# Have to do this because git ignores empty dirs
# [ -d resources-home-dev/work ] || mkdir resources-home-dev/work

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

    log/start "Preludes"

    for n in $DA_MODULES ; do 
        m=modules/$n
        echo "# $m"
        if [ -f $m/prelude.docker ] ; then
            log/start "Prelude $m"
            cat $m/prelude.docker
            echo
        fi
    done

    log/start "Install Modules"
    echo "USER root"

    for n in $DA_MODULES ; do 
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

    for n in $DA_MODULES ; do 
        m=modules/$n
        if [ -f $m/configure.sh ] ; then
            log/start "Configure $m"
            echo "COPY --chown=dev:dev $m/configure.sh configure.sh"
            echo 'RUN source configure.sh && rm configure.sh'
        fi
    done

    echo

) > Dockerfile

docker build -t $NAME . | tee -a build.log