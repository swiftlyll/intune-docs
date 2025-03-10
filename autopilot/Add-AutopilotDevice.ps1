<#
.DESCRIPTION
    Registers device into Windows Autopilot.This is mainly to load on a USB for quick use.
.NOTES
    Author: Kennet Morales
    Date: March 14, 2024
    GitHub: https://github.com/swiftlyll
    Source: https://learn.microsoft.com/en-us/autopilot/add-devices#directly-upload-the-hardware-hash-to-an-mdm-service
#>

# TLS 1.2 for data-in-transit
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# install and run script
try {
    Write-Output "Starting enrollment"
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
    Install-Script -Name Get-WindowsAutopilotInfo -Force -ErrorAction Stop
    Get-WindowsAutopilotInfo -Online -ErrorAction Stop
    Write-Output "Enrollment complete"
    Exit 0
}
catch {
    Write-Output "Enrollment failed"
    Exit 1
}
