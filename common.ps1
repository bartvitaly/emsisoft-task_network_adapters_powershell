# get list of all enabled network adapters
function GetEnabledNetDevices {
    try
    {
        return Get-Pnpdevice -Class 'Net' -PresentOnly -Status OK
    }
    catch
    {
        Write-Host 'Error when retreiving the list of devices'
    }
}

function GetAllNetDevices {
    try
    {
        return (Get-Pnpdevice -Class 'Net')
    }
    catch
    {
        Write-Host 'Error when retreiving the list of devices'
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