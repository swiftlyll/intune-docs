<#
.DESCRIPTION
    Copies some shorcut to a user's desktop
.NOTES
    Author: Kennet Morales
    Date: 04/22/2024
    GitHub: https://github.com/swiftlyll
#>

<# Variables #>
$userDesktop = [System.Environment]::GetFolderPath("DesktopDirectory")
# Optional: Push out to all users, or use with Win32 deployments
# $globalPath = "C:\Users\Public\Desktop" 

$myShortcut = @{
    Path = "some\random\path"
    Destination = $userDesktop # replace with $globalPath for all users
    Confirm = $false
    Force = $true
    ErrorAction = "Stop"
}

<# Create #>
Write-Output ""
Copy-Item @myShortcut
Write-Output ""