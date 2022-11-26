Import-Module $PSScriptRoot\check_one_enabled.ps1

$devices = GetEnabledNetDevices
$max = $devices.Count - 1

# return Index and Name of all enabled adapters
for($i=0; $i -le $max; $i++)
{
    Write-Host $i, $devices[$i].Name
}
