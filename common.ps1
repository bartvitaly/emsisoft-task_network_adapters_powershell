# get list of all enabled network adapters
function GetEnabledNetDevices {
    try
    {
        $res = Get-Pnpdevice -Class 'Net' -PresentOnly -Status OK -ErrorAction Stop
        return $res
    }
    catch
    {
        Write-Host 'Error when retrieving the list of devices. Probable reason: all devices are disabled.'
    }
}

function GetAllNetDevices {
    try
    {
        $res = Get-Pnpdevice -Class 'Net' -ErrorAction Stop
        return $res
    }
    catch
    {
        Write-Host 'Error when retrieving the list of devices. Probable reason: all devices are disabled.'
    }
}

function CheckStatus($instanceId, $statusExpected)
{
    $statusActual = (Get-Pnpdevice -Class 'Net' -PresentOnly -InstanceId $instanceId).Status
    if ($statusActual -eq $statusExpected)
    {
        return $true
    }
    else 
    {
        return $false
    }
}

function EnableAllDevices {
    $devices = GetAllNetDevices

    for($i=0; $i -le ($devices.Count - 1); $i++)
    {
        $device = [String]$devices[$i].InstanceId
        Enable-PnpDevice -InstanceId $device -Confirm:$False
    }
}