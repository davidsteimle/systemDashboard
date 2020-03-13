# System Dashboard

Tools for creating a system bashboard the hard way.

# Files

## Utility Files

These are worker files to do some of the work along the way. They perform general tasks which might be useful outside of this project.

### Get-LsbRelease.ps1

This ia powershell script that takes the output from ``lsb_release -a`` and converts it to a powershell object. ([link](https://github.com/davidsteimle/systemDashboard/blob/master/Get-LsbRelease.ps1)). Bash, like CMD, returns strings only. Converting this output to an object makes it more useful. This process inspired by [Ryan Leap's PSSaturday Talk](https://github.com/ryan-leap/PsSaturday)

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

The result of the script can be returned as a variable.

```powershell
$x = Get-LsbRelease.ps1
```
