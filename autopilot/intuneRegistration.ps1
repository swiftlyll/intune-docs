<#
.DESCRIPTION
    Registers device to Intune
.NOTES
    Author: Kennet Morales
    Date: March 14, 2024
    Modified: May 14, 2024
    GitHub: https://github.com/swiftlyll
#>

# TLS 1.2 for Data-in-Transit Encryption
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Setup for Autopilot Script
Write-Host -ForegroundColor Yellow "[INFO] Installing Autopilot script" | Write-Output
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass # Prevents errors/blocking of scripts
Install-Script -Name Get-WindowsAutopilotInfo -Force # Downloads script
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned # Reverts changes
Write-Host -ForegroundColor Yellow "[INFO] Installation successful" | Write-Output

# Collect Hash
try {
    Write-Host -ForegroundColor Yellow "[INFO] Enrolling, please log-in with admin" | Write-Output
    Get-WindowsAutopilotInfo -Online -ErrorAction Stop
    Write-Host -ForegroundColor Yellow "[INFO] Sucessfully enrolled device" | Write-Output
    Exit 0
}
catch {
    Write-Host -ForegroundColor Red "[ERROR] Enrollment failed" | Write-Output
    Exit 1
}