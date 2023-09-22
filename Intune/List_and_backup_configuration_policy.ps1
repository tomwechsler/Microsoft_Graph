#Use PowerShell Version 5.1 not 7
Install-Module -Name Microsoft.Graph.Intune -Verbose

#Import the Microsoft Graph Intune module
Import-Module -Name Microsoft.Graph.Intune -Verbose

#Connect to the Microsoft Intune service
Connect-MSGraph 

#Retrieve a list of all profiles and policies in Intune
$policies = Get-IntuneDeviceConfigurationPolicy

#Create backup folder if it doesn't exist
$backupFolder = "C:\IntuneBackup"
if (-not (Test-Path -Path $backupFolder -PathType Container)) {
    New-Item -ItemType Directory -Path $backupFolder | Out-Null
}

#Show display name and creation date of each policy in a table format with green color in the terminal, and export to a JSON file in the backup folder
$table = @()
foreach ($policy in $policies) {
    $row = [pscustomobject]@{
        "Display Name" = $policy.DisplayName
        "Creation Date" = $policy.CreatedDateTime
    }
    $table += $row
    $policy | ConvertTo-Json | Out-File -FilePath "$backupFolder\$($policy.DisplayName).json"
}
$table | Format-Table -AutoSize