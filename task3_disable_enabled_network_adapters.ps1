# Script to disable enabled adapters
Import-Module $PSScriptRoot\common.ps1

$devices = GetEnabledNetDevices
[System.Collections.ArrayList]$result = @()

# disable enabled adapters
foreach($device in $devices)
{
    $res = DisableDevice($device)
    if ($res)
    {
        Write-Host 'Device:', $device.Name, 'is disabled.'
        [void]$result.Add($device.Name)
    }
    else
    {
        Write-Host 'Device:', $device.Name, 'was not disabled!'
    }
}

# Write to file if there are disabled devices
if ($result.Count -gt 0)
{
    $result | Out-File -FilePath $PSScriptRoot\disabled_adapters.txt
}
