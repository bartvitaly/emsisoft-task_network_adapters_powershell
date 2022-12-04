# Script to return enabled devices

Import-Module $PSScriptRoot\common.ps1

$devices = GetEnabledNetDevices
$i = 0
[System.Collections.ArrayList]$result = @()

# return Index and Name of all enabled adapters
foreach($device in $devices)
{
    [void]$result.Add([String]$i + ' ' + $device.Name)
    $i++
}

return $result