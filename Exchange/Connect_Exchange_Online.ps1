Set-Location C:\
Clear-Host

#Set the Execution Policy (Windows)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Install into the Current User Scope
Install-Module Microsoft.Graph -Scope CurrentUser -AllowClobber -Verbose -Force

#If needed
Import-Module Microsoft.Graph

#Connection for Creating, Reading, Updating, and Deleting Mail
$scopes = @("Mail.ReadWrite")
Connect-MgGraph -Scopes $scopes

#We search for my UserID
Get-MgUser

Get-MgUser -All | Format-List  ID, DisplayName, Mail, UserPrincipalName

#We search for the permissions
Find-MgGraphCommand -command Get-MgUserMailFolder | Select-Object -First 1 -ExpandProperty Permissions

Find-MgGraphCommand -command Get-MgUserMailboxSetting | Select-Object -First 1 -ExpandProperty Permissions

#An example
$User = Get-MgUser -UserId "b41b6fbd-8da5-4e68-a2f3-2288d682f1f0"
$mailfolders = Get-MgUserMailFolder -UserId $User.Id -All
$mailfolders

#Connection for Sending Mail as Users in the Organization
$scopes = @("SMTP.Send")
Connect-MgGraph -Scopes $scopes

#Connection for Creating, Reading, Updating, and Deleting Events in User Calendars
$scopes = @("Calendars.ReadWrite")
Connect-MgGraph -Scopes $scopes

#An example
$User = Get-MgUser -UserId "b41b6fbd-8da5-4e68-a2f3-2288d682f1f0"
$calendar = Get-MgUserCalendar -UserId $User.Id -All
$calendar

#Core Connection for Managing Mail and Calendar
$scopes = @("Mail.ReadWrite","Calendars.ReadWrite")
Connect-MgGraph -Scopes $scopes