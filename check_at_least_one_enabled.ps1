# Script to check if at least one network adapter is enabled

# get list of all enabled network adapters
function GetEnabledNetDevices {
  return (Get-Pnpdevice -Class 'Net' -PresentOnly -Status OK)
}

# return True if at least one network adapter is enabled
if ({GetEnabledNetDevices}.Count -gt 0) {
    return 'True'
}