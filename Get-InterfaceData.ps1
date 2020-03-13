#!/usr/bin/env pwsh

class iface {
    [string]$HWaddr
    [string]$IPv4
    [string]$Broadcast
    [string]$Mask
    [string]$IPv6
    [string]$Scope
}

$interfaceNames = $(ls /sys/class/net).Split(" ")

$Interfaces = [System.Collections.ArrayList]::new

foreach($interface in $interfaceNames){
    if($interface -ne 'lo'){
        $ThisInterface =  New-Object -TypeName iface
        $Result = ifconfig $interface
        # https://vexx32.github.io/2018/11/08/Named-Regex-Matches-PSCustomObject/
        $MatchPattern = @(
            '(?<hwaddr>HWaddr [a-fA-F0-9]{1,2}:[a-fA-F0-9]{1,2}:[a-fA-F0-9]{1,2}:[a-fA-F0-9]{1,2}:[a-fA-F0-9]{1,2}:[a-fA-F0-9]{1,2})'
            '(?<inet>inet addr:[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,})'
            '(?<bcast>Bcast:[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,})'
            '(?<mask>Mask:[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,})'
            '(?<inet6>inet6 addr: [a-fA-F0-9]{1,4}::[a-fA-F0-9]{1,4}:[a-fA-F0-9]{1,4}:[a-fA-F0-9]{1,4}:[a-fA-F0-9]{1,4}/[0-9]{1,2})'
            '(?<scope>Scope:.{1,})'
        ) -join '\s+'
        $Result -match $MatchPattern
        $ThisInterface.HWaddr = $(($Matches.hwaddr).Replace("HWaddr ",""))
        $ThisInterface.IPv4 = $(($Matches.inet).Replace("inet addr:",""))
        $ThisInterface.Broadcast = $(($Matches.bcast).Replace("Bcast:",""))
        $ThisInterface.Mask = $(($Matches.mask).Replace("Mask:",""))
        $ThisInterface.IPv6 = $(($Matches.inet6).Replace("inet6 addr: ",""))
        $ThisInterface.Scope = $(($Matches.scope).Replace("Scope:",""))
    }
}
