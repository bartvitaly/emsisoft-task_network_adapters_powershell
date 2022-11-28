$DeviceActionTimeout = 10

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

function DisableDevice($instanceId)
{
    for ($i=0; $i -le 3; $i++)
    {
        try
        {
            Disable-PnpDevice -InstanceId $instanceId -Confirm:$false
        }
        catch {
            Write-Host 'Error when when disabling device.'
        }
        $res = CheckStatus $instanceId OK
        if ($res -eq $true) {
            Write-Host 'Device was not disabled, trying again.'
            Start-Sleep -Seconds $DeviceActionTimeout
        }
        else 
        {
            return $res
        }
    }
    return $res
}

function EnableDevice($instanceId)
{
    for ($i=0; $i -le 3; $i++)
    {
        try
        {
            Enable-PnpDevice -InstanceId $instanceId -Confirm:$False
        }
        catch {
            Write-Host 'Error when when enabling device.'
        }
        $res = CheckStatus $instanceId OK
        if ($res -eq $false) {
            Write-Host 'Device was not enabled, trying again.'
            Start-Sleep -Seconds $DeviceActionTimeout
        }
        else
        {
            return $res        
        }
    }
    return $res
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