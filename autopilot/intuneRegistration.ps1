<#
.DESCRIPTION
    Registers device to Intune
.NOTES
    Author: Kennet Morales
    Date: March 14, 2024
    GitHub: https://github.com/swiftlyll
    Source: 
#>

# TLS 1.2 for Data-in-Transit Encryption
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# install autopilot script
Write-Output "[INFO] Installing Autopilot script"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass # Prevents errors/blocking of scripts
Install-Script -Name Get-WindowsAutopilotInfo -Force # Downloads script
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned # Reverts changes
Write-Output "[INFO] Installation successful"

# enroll
Write-Output "[INFO] Please log-in with admin" 
Get-WindowsAutopilotInfo -Online -ErrorAction Stop
Write-Output "[INFO] Sucessfully enrolled device" 
Exit 0