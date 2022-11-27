# Script to return enabled devices

Import-Module $PSScriptRoot\common.ps1

$devices = GetEnabledNetDevices
$max = $devices.Count - 1
$result = @([void]$max)

# return Index and Name of all enabled adapters
for($i=0; $i -le $max; $i++)
{
  [void]$result.add([String]$i + ' ' + $devices[$i].Name)
}

return $result