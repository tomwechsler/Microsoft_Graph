#Install the NuGet Provider
Install-PackageProvider -Name NuGet -Force

#Set the Execution Policy (Windows)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Install into the Current User Scope
Install-Module Microsoft.Graph -Scope CurrentUser

#Install into the All-User Scope
Install-Module Microsoft.Graph -Scope AllUsers -Force -Verbose

#Verify the Installation
Get-InstalledModule Microsoft.Graph

#Updating the Module
Update-Module Microsoft.Graph
