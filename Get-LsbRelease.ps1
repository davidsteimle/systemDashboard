#!/usr/bin/env pwsh

class lsb {
    [string]$DistributorID
    [string]$Description
    [string]$Release
    [string]$Codename
}

$x = lsb_release -a

$Result = [lsb]::new()

foreach($y in $x){
    $a = $y.Split(':')
    $a[0] = $a[0].Replace(" ","")
    $Result.$($a[0]) = $($a[1].Trim())
}

$Result
