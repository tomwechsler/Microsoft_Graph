#Set the Execution Policy (Windows)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Install Microsoft Graph PowerShell SDK
Install-Module Microsoft.Graph -Force -Verbose -AllowClobber

#Verify the Installation
Get-InstalledModule Microsoft.Graph

#We search for the permissions
Find-MgGraphCommand -Command Get-MgUserPhoto | Select-Object -First 1 -ExpandProperty Permissions

Find-MgGraphCommand -Command Set-MgUserPhotoContent | Select-Object -First 1 -ExpandProperty Permissions

#Connect to Microsoft Graph using Scopes
Connect-MgGraph -Scopes "User.ReadWrite.All"

#We check the permissions
(Get-MgContext).Scopes

#Get information about users
Get-MgUser

#Get information about user photos
Get-MgUserPhoto -UserId NestorW@63k57q.onmicrosoft.com

#Add user photos
Set-MgUserPhotoContent -UserId NestorW@63k57q.onmicrosoft.com -InFile "C:\Upload\NestorW.png"

#Download user photos
Get-MgUserPhotoContent -UserId NestorW@63k57q.onmicrosoft.com -OutFile "C:\Download\NestorW.png"

#Remove user photos
Remove-MgUserPhoto -UserId NestorW@63k57q.onmicrosoft.com

#Disconnect from Microsoft Graph
Disconnect-MgGraph
