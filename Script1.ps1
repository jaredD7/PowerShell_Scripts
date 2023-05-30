$drives = Get-PhysicalDisk

$report = @()

foreach ($drive in $drives) {
    $driveInfo = Get-PhysicalDisk -UniqueId $drive.UniqueId
    $volumeInfo = Get-Partition -InputObject $driveInfo | Get-Volume

    $driveData = [PSCustomObject]@{
        DriveID           = $drive.DeviceID
        HealthStatus      = $driveInfo.HealthStatus
        OperationalStatus = $driveInfo.OperationalStatus
        Size              = $driveInfo.Size
        FileSystem        = $null
        DriveLetter       = $null
        UsedSpace         = $null
        FreeSpace         = $null
    }
    
    if ($volumeInfo) {
        $driveData.FileSystem  = $volumeInfo.FileSystem
        $driveData.DriveLetter = $volumeInfo.DriveLetter
        $driveData.UsedSpace   = $volumeInfo.Size - $volumeInfo.SizeRemaining
        $driveData.FreeSpace   = $volumeInfo.SizeRemaining
    }

    $report += $driveData
}

$report | Format-Table -AutoSize