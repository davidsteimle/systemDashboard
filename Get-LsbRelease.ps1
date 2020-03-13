#!/usr/bin/env pwsh

class lsb {
    [string]$DistributorID
    [string]$Description
    [string]$Release
    [string]$Codename
}

$lsbRaw = try{ lsb_release -a } catch { return }

$Result = [lsb]::new()

foreach($y in $lsbRaw){
    $a = $y.Split(':')
    $a[0] = $a[0].Replace(" ","")
    $Result.$($a[0]) = $($a[1].Trim())
}

$Result
