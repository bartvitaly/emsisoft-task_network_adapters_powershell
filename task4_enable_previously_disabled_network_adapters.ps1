# Script to disable enabled adapters

Import-Module $PSScriptRoot\common.ps1

$devices = Get-Content -Path $PSScriptRoot\disabled_adapters.txt

foreach($device in $devices)
{ 
    $res = EnableDevice($device)
    if ($res)
    {
        Write-Host 'Device:', $device, 'is enabled.'
    }
    else 
    {
        Write-Host 'Device:', $device, 'was not enabled!'
    }
}