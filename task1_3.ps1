# Script to disable enabled adapters
Import-Module $PSScriptRoot\common.ps1

$enabledDevices = GetEnabledNetDevices
$max = $enabledDevices.Count - 1
[System.Collections.ArrayList]$result = @()

# disable enabled adapters
for($i=0; $i -le $max; $i++)
{
    $InstanceId = $enabledDevices[$i].InstanceId
    $res = DisableDevice($InstanceId)
    if ($res)
    {
        Write-Host 'Device:', $enabledDevices[$i].Name, 'was not disabled!'    
    }
    else
    {
        Write-Host 'Device:', $enabledDevices[$i].Name, 'is disabled.'
        [void]$result.Add($InstanceId)
    }
}

# Write to file if there are disabled devices
if ($result.Count -gt 1)
{
    $result | Out-File -FilePath $PSScriptRoot\disabled_adapters.txt
}
