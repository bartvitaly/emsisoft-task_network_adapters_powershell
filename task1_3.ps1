# Script to disable enabled adapters
Import-Module $PSScriptRoot\common.ps1

$enabledDevices = GetEnabledNetDevices
$max = $enabledDevices.Count - 1
[System.Collections.ArrayList]$result = @()

# disable enabled adapters
for($i=0; $i -le $max; $i++)
{
    $device = $enabledDevices[$i].InstanceId
    Disable-PnpDevice -InstanceId $device -Confirm:$False
    $res = CheckStatus $device OK
    if ($res)
    {
        Write-Host 'Device:', $enabledDevices[$i].Name, 'was not disabled!'    
    }
    else
    {
        Write-Host 'Device:', $enabledDevices[$i].Name, 'is disabled.'
        [void]$result.Add($device)
    }
}

$result | Out-File -FilePath $PSScriptRoot\disabled_adapters.txt
