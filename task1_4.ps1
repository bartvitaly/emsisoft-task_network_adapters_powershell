# Script to disable enabled adapters

Import-Module $PSScriptRoot\common.ps1

$devices = Get-Content -Path $PSScriptRoot\disabled_adapters.txt
$max = $devices.Count - 1

for($i=0; $i -le $max; $i++)
{ 
    $res = EnableDevice([String]$devices[$i])
    if ($res)
    {
        Write-Host 'Device:', $devices[$i], 'is enabled.'
    }
    else 
    {
        Write-Host 'Device:', $devices[$i], 'was not enabled!'
    }
}