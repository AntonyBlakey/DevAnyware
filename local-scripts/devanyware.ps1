#!/usr/bin/env pwsh

Param (
    [Parameter()] [string] $Image,
    [Parameter()] [Int32] $VNC,
    [Parameter()] [string] $Name,
    [Parameter()] [switch] $NoDocker,
    [Parameter()] [string] $HostMap,
    [Parameter()] [switch] $NoHostMap
)

if ($NoDocker) {
    $dockerMapping = ""
}
else {
    $ip = (Get-NetIPAddress -InterfaceAlias "vEthernet (DockerNAT)" -AddressFamily IPv4).IPAddress
    $dockerMapping = "-e DOCKER_HOST=tcp://${ip}:2375"
}

if ($NoHostMap) {
    $hostMapping = ""
}
else {
    if ($PSBoundParameters.ContainsKey('HostMap')) {
        $hostMapping = "-v ${HostMap}:/host"
    }
    else {
        $hostMapping = "-v ${PWD}:/host"
    }
}

if ($PSBoundParameters.ContainsKey('Image')) {
    $image = "${env:DEVANYWARE_IMAGE_PREFIX}$Image"
}
else {
    $username = $env:USERNAME.ToLower()
    $image = "${env:DEVANYWARE_USER_IMAGE_PREFIX}${username}"
}

if ($PSBoundParameters.ContainsKey('VNC')) {
    $vncPortmap = "-p ${VNC}:5900"
    $itord = "-d"
    $cmd = "start-vnc"
}
else {
    $vncPortmap = "" 
    $itord = "-it"
    $cmd = ""
}

if ($PSBoundParameters.ContainsKey('Name')) {
    $name = $Name
    $rm = ""
}
else {
    $random = -join ((97..122) * 10 | Get-Random -Count 8 | % {[char]$_})
    $lastNameSegment = ($image -split '/')[-1]
    $name = "$lastNameSegment-$random"
    $rm = "--rm"
}

docker run --cap-add SYS_ADMIN --shm-size 1G $itord $rm --name $name -h $name --dns-opt=single-request $vncPortmap $dockerMapping $hostMapping $image $cmd