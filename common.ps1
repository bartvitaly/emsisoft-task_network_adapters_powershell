$DeviceActionTimeout = 10

# get list of all enabled network adapters
function GetEnabledNetDevices {
    return (Get-NetAdapter -Name "*" | where Status -eq 'Up')
}

function GetAllNetDevices {
    return Get-NetAdapter
}

function DisableDevice($device)
{
    for ($i=0; $i -le 3; $i++)
    {
        try
        {
            Disable-NetAdapter $device.Name -Confirm:$False
        }
        catch {
            Write-Host 'Error when when disabling device.'
        }
        $status = (Get-NetAdapter $device.Name).Status
        if ($res -eq 'Disabled') {
            return $res
        }
        else 
        {
            Write-Host 'Device was not disabled, trying again.'
            Start-Sleep -Seconds $DeviceActionTimeout
        }
    }
    return $res
}

function EnableDevice($name)
{
    for ($i=0; $i -le 3; $i++)
    {
        try
        {
            Enable-NetAdapter $name -Confirm:$False
        }
        catch {
            Write-Host 'Error when when enabling device.'
        }
        $status = (Get-NetAdapter $name).Status
        if ($status -eq 'Up') {
            Write-Host 'Device was not enabled. Trying again...'
            Start-Sleep -Seconds $DeviceActionTimeout
        }
        else
        {
            return $res        
        }
    }
    return $res
}
function CheckStatus($name, $statusExpected)
{
    $statusActual = (Get-NetAdapter $name).Status
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
        Enable-PnpDevice -InstanceId $device -Confirm:$False -ErrorAction Stop
    }
}