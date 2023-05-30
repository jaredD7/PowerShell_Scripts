$drives = Get-PhysicalDisk

foreach ($drive in $drives) {
    $driveInfo = Get-PhysicalDisk -UniqueId $drive.UniqueId
    $volumeInfo = Get-Partition -InputObject $driveInfo | Get-Volume

    Write-Host "Drive $($drive.DeviceID):"
    Write-Host "Health Status: $($driveInfo.HealthStatus)"
    Write-Host "Operational Status: $($driveInfo.OperationalStatus)"
    Write-Host "Size: $($driveInfo.Size) bytes"
    
    if ($volumeInfo) {
        Write-Host "File System: $($volumeInfo.FileSystem)"
        Write-Host "Drive Letter: $($volumeInfo.DriveLetter)"
        Write-Host "Used Space: $($volumeInfo.Size - $volumeInfo.SizeRemaining) bytes"
        Write-Host "Free Space: $($volumeInfo.SizeRemaining) bytes"
    } else {
        Write-Host "No volume information available."
    }

    Write-Host "------------------------"
}