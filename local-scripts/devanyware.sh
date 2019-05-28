#!/usr/bin/env zsh

if [ $# -eq 0 ] ; then
    image="${DEVANYWARE_USER_IMAGE_PREFIX}$(whoami)"
elif [[ "$1" =~ '^-.*' ]] ; then
    image="${DEVANYWARE_USER_IMAGE_PREFIX}$(whoami)"
else
    image="${DEVANYWARE_IMAGE_PREFIX}$1"
    shift
fi

# Perl undoubtedly would be more concise
ADDR=$(ping me | gawk -e '/([0-9]{1,3}\.){3}[0-9]{1,3}/ { match($0,/(([0-9]{1,3}\.){3}[0-9]{1,3})/,arr); print arr[0] ; exit }' -)

zparseopts -D                \
    e+:=environment          \
    p+:=ports                \
    v+:=volumes              \
    -link+:=links             \
    -name:=name              \
    -vnc::=vnc_port          \
    -no-docker=no_docker     \
    -host-map::=host_map         \
    -no-host_map=no_host_map

if [ -n "$no_host_map" ] ; then
    host_mapping=
else
    host_mapping=-v=${${host_map:+${host_map#--host}}:-$(pwd)}:/host
fi

vnc_port=${vnc_port:+${${vnc_port#--vnc}:-5910}}
if [ -z "$vnc_port" ] ; then
    itord=-it
    vnc_portmap=
    cmd=$*
else
    itord=-d
    vnc_portmap=-p=${ADDR}:${vnc_port}:5900
    if [ -z "$*" ] ; then
        cmd=start-vnc
    else
        cmd=$*
    fi
fi

if [ -z "$name" ] ; then
    name=${image##*/}-${vnc_port:-$(cat /dev/urandom | base64 | tr -dc 'a-z' | head -c 8)}
    rm=--rm
else
    name=${name[2]}
    rm=
fi

if [ -z "$no_docker" ] ; then
    docker_mapping="-v=/var/run/docker.sock:/var/run/docker.sock"
fi

docker \
    run --cap-add SYS_ADMIN --shm-size 1G $itord $rm --name $name -h $name --dns-opt=single-request \
    $links $environment $ports $volumes $vnc_portmap $docker_mapping $host_mapping \
    $image $cmd