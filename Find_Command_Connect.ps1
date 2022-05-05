#Finding Available cmdlets
Import-Module Microsoft.Graph

Get-Command -Module Microsoft.Graph*

Get-Command -Module Microsoft.Graph* *Team*

Get-Command -Module Microsoft.Graph* *User*

Get-Command -Module Microsoft.Graph* -Noun *Group*

Get-Command -Module Microsoft.Graph.Authentication


#Getting Help for a cmdlet
Get-Help Get-MgUser

Get-Help Get-MgUser -Category Cmdlet

Get-Help Get-MgUser -Category Function

Get-Help Get-MgUser -Detailed

Get-Help Get-MgUser -Full

Get-Help Get-MgUser –ShowWindow

#Set the API Version
#View the current API endpoint version
Get-MgProfile

#Set the API to the 'beta' endpoint
Select-MgProfile -Name "beta"

#Set the API to the 'v1.0' endpoint
Select-MgProfile -Name "v1.0"

#Connect to Microsoft 365 using Scopes
#Scopes to Manage Users and Groups with Full Read Write Access
$scopes = @(
    "User.ReadWrite.All"
    "Directory.ReadWrite.All"
    "Group.ReadWrite.All"
    )

#Scopes to Create Teams
$scopes = @("Team.Create"
    "Group.ReadWrite.All"
    )

#Scopes to Manage SharePoint Online Sites and Files
$scopes = @("Sites.FullControl.All"
    "Sites.Manage.All"
    "Sites.ReadWrite.All"
    "Files.ReadWrite.All"
    "Files.ReadWrite.AppFolder"
    )

#Scopes to Manage Mail
$scopes = @("Mail.ReadWrite"
    "Mail.ReadWrite.Shared"
    "Mail.Send"
    )

#Finding Available Permissions
#SharePoint Sites
Find-MgGraphPermission sites -PermissionType Delegated

#Microsoft Teams
Find-MgGraphPermission teams -PermissionType Delegated

#Users
Find-MgGraphPermission user -PermissionType Delegated

#eDiscovery
Find-MgGraphPermission ediscovery -PermissionType Delegated

#Connect Using the Standard Command and Scopes
$scopes = @("User.ReadWrite.All"
    "Directory.Read.All"
    "Group.Read.All"
    )
Connect-MgGraph -Scopes $scopes

#Connect Using an Azure App Registration
Connect-MgGraph -ClientId <your ClientId> -TenantId <your TenantId> -CertificateThumbprint <your CertificateThumbprint>