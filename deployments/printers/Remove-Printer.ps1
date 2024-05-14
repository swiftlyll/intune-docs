<#
.DESCRIPTION
    Generic printer removal script for for Win32 deployment
.NOTES
    Author: Kennet Morales
    Date: 05/06/2024
#>

<# Enumerate Printers #>
$printerPorts = @{
    portA = ""
    portB = ""
    portC = ""
    portD = ""
}

Write-Output "[INFO] Enumerating printers"
$printers = Get-Printer -ErrorAction SilentlyContinue | Where-Object -FilterScript {$printerPorts.Values -contains $_.PortName}

<# Remove Printers and Associated Ports #>
try {

    foreach ($printer in $printers) {
        # Printer
        Write-Output "[INFO] Removing printer $($printer.Name)"
        Remove-Printer -Name $printer.Name -Confirm:$false -ErrorAction SilentlyContinue
        Write-Output "[INFO] Successfully removed printer $($printer.Name)"
        # Port
        Write-Output "[INFO] Removing printer port associated with $($printer.Name)"
        Remove-PrinterPort -Name $printer.PortName -Confirm:$false -ErrorAction SilentlyContinue
        Write-Output "[INFO] Successfully removed printer port $($printer.PortName)"
        #Status
        Write-Output "[INFO] Removal complete"
        Exit 0
    }

}

catch {

    Write-Output "[ERROR] Failed to remove printers"
    Exit 1

}