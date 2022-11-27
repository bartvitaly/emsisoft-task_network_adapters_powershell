# Script to return enabled devices

Import-Module $PSScriptRoot\common.ps1

$devices = GetEnabledNetDevices
$max = $devices.Count - 1
[System.Collections.ArrayList]$result = @()

# return Index and Name of all enabled adapters
for($i=0; $i -le $max; $i++)
{
  [void]$result.Add([String]$i + ' ' + $devices[$i].Name)
}

return $result