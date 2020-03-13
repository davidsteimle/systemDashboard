# System Dashboard

Tools for creating a system bashboard the hard way.

# Files

## Get-LsbRelease.ps1

This ia powershell script that takes the output from ``lsb_release -a`` and converts it to a powershell object. ([link](https://github.com/davidsteimle/systemDashboard/blob/master/Get-LsbRelease.ps1))

Sample output from Linux :

```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 16.04.6 LTS
Release:        16.04
Codename:       xenial
```

When powershell is used to assign this as a variable (like ``$x = lsb_release -a``) it will ignore the "No LSB modules are available" line, as that is in the error stream.

``Get-LsbRelease.ps1`` will capture the output and return a powershell custom object.

```
PS> $Result | Format-List

DistributorID : Ubuntu
Description   : Ubuntu 16.04.6 LTS
Release       : 16.04
Codename      : xenial

PS> $Result | Format-Table

DistributorID Description        Release Codename
------------- -----------        ------- --------
Ubuntu        Ubuntu 16.04.6 LTS 16.04   xenial
```
