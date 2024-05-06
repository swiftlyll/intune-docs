<#
.SYNOPSIS
    Generic printer driver installation script for Win32 deployment
.NOTES
    Author: Kennet Morales
    Date: 05/06/2024
#>

<# Driver Information #>
$scriptPath = ".\Install-Driver.ps1"

$driverStore = "path\to\driver\store\driverStore.inf" # Ensure .inf requirements are present

$printerDriver = @{
    Name = ""
    ErrorAction = "Stop"
}

<# 64bit Confirmation #>
if ($ENV:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
    
    try {
        & "$ENV:WINDIR\SysNative\WindowsPowershell\v1.0\PowerShell.exe" -File $scriptPath
    }
    catch {
        Write-Output "[ERROR] Installation script failed to run"
        Exit 1
    }

}

<# Driver Installation #>
else {

    try {
        # Driver Store  
        Write-Output "[INFO] Installing driver store"
        pnputil.exe /add-driver $driverStore
        Write-Output "[INFO] Successfully installed driver store"
        # Driver
        Write-Output "[INFO] Installing driver $($printerDriver.Name)"
        Add-PrinterDriver @printerDriver
        Write-Output "[INFO] Successfully installed driver $($printerDriver.Name)"
        # Status
        Write-Output "[INFO] Installation complete"
        Exit 0 
    }
    catch {
        Write-Output "[ERROR] Driver installation failed"
        Exit 1
    }

}