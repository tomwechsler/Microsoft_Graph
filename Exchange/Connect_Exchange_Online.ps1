Set-Location C:\
Clear-Host

#If needed
Import-Module Microsoft.Graph

#Set the API to the 'beta' endpoint
Select-MgProfile -Name "beta"

#We check the profile
Get-MgProfile

#Connection for Creating, Reading, Updating, and Deleting Mail
$scopes = @("Mail.ReadWrite")
Connect-MgGraph -Scopes $scopes

#We search for my a UserID
Get-MgUser

#An example
$User = Get-MgUser -UserId "03462391-f62e-4fcb-b6ca-e6e74a9c4ba7"
$mailfolders = Get-MgUserMailFolder -UserId $User.Id -All
$mailfolders

#Connection for Sending Mail as Users in the Organization
$scopes = @("SMTP.Send")
Connect-MgGraph -Scopes $scopes

#Connection for Creating, Reading, Updating, and Deleting Events in User Calendars
$scopes = @("Calendars.ReadWrite")
Connect-MgGraph -Scopes $scopes

#An example
$User = Get-MgUser -UserId "03462391-f62e-4fcb-b6ca-e6e74a9c4ba7"
$calendar = Get-MgUserCalendar -UserId $User.Id -All
$calendar

#Core Connection for Managing Mail and Calendar
$scopes = @("Mail.ReadWrite","Calendars.ReadWrite")
Connect-MgGraph -Scopes $scopes