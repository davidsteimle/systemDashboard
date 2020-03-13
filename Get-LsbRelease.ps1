#!/usr/bin/env pwsh

class lsb {
    [string]$DistributorID
    [string]$Description
    [string]$Release
    [string]$Codename
}

$x = lsb_release -a

$z = foreach($y in $x){
    $a = $y.Split(':')
    $y = @{$($a[0].Replace(" ","")) = $($a[1].Trim())}
    $y
}

$z

