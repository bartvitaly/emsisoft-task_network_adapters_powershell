# Script to check if at least one network adapter is enabled
Import-Module $PSScriptRoot\common.ps1

$enabledDevices = GetEnabledNetDevices

# return True if at least one network adapter is enabled
if ($enabledDevices -ne $null) {
    return $true
}