#Search with winget for the app you want to deploy
winget search "Cisco"

#Search for the winget app that is an msstore app
winget search -s msstore "Cisco"

#To make some space below
Set-Location C:\
Clear-Host

#Istall the module. (You need admin on the machine.)
Install-Module Microsoft.Graph -AllowClobber -Verbose -Force

#Connect to the graph (incl. necessary permissions) DeviceManagementApps.ReadWrite.All, DeviceManagementApps.Read.All
Connect-MgGraph 

#We check the permissions
(Get-MgContext).Scopes

#Search for specific cmdlets
Get-Command *-mgGraphRequest*

#Create some variables
$displayName = "Cisco Any Connect"
$ApplicationId = "9WZDNCRDJ8LH"

#Create the body
$body = @"
{
    "@odata.type": "#microsoft.graph.winGetApp",
    "displayName": "$($displayName)",
    "packageIdentifier": "$($ApplicationId)",
    "installExperience": {
        "runAsAccount": "system"
    }
}
"@

#Create the URI
$uri = 'https://graph.microsoft.com/beta/deviceAppManagement/mobileApps'

#Create the app
Invoke-MgGraphRequest -Method POST -Body $body -Uri $uri