<#
.DESCRIPTION
    Generic printer driver removal script for Win32 deployment
.NOTES
    Author: Kennet Morales
    Date: 05/06/2024
#>

<# Driver Information #>
$scriptPath = ".\Remove-Driver.ps1"

$driverStore = "path\to\driver\store\driverStore.inf"

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

<# Driver Removal #>
else {

    try {
        # Driver
        Write-Output "[INFO] Removing driver $($printerDriver.Name)"
        Remove-PrinterDriver @printerDriver
        Write-Output "[INFO] Successfully removed driver $($printerDriver.Name)"
        # Driver Store  
        Write-Output "[INFO] Removing driver store"
        pnputil.exe /delete-driver $driverStore /uninstall /force
        Write-Output "[INFO] Successfully removed driver store"
        # Status
        Write-Output "[INFO] Removal complete"
        Exit 0 
    }
    catch {
        Write-Output "[ERROR] Driver removal failed"
        Exit 1
    }

}