# Script to disable enabled adapters

Import-Module $PSScriptRoot\common.ps1

$devices = Get-Content -Path $PSScriptRoot\disabled_adapters.txt
$max = $devices.Count - 1

for($i=0; $i -le $max; $i++)
{
    $device = [String]$devices[$i]
    Enable-PnpDevice -InstanceId $device -Confirm:$False
    $res = CheckStatus $device OK
    if ($res)
    {
        Write-Host 'Device:', $device, 'is enabled.'
    }
    else 
    {
        Write-Host 'Device:', $device, 'was not enabled!'
    }
}