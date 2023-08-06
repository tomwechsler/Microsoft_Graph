#Install Microsoft Graph Module
Install-Module Microsoft.Graph -AllowClobber -Force

$scopes = @(

"Group.ReadWrite.All",

"GroupMember.ReadWrite.All",

"TeamsApp.ReadWrite.All",

"TeamsAppInstallation.ReadWriteForTeam",

"TeamsAppInstallation.ReadWriteSelfForTeam",

"TeamSettings.ReadWrite.All",

"TeamsTab.ReadWrite.All",

"TeamMember.ReadWrite.All"

)

Connect-MgGraph -Scopes $scopes

#List the groups
$group = Get-MgGroup | Format-List Id, DisplayName, Description, GroupTypes

#Retrieve Teams by ID
$team = Get-MgTeam -TeamId $group.Id

Write-Host $team.DisplayName

#View All Properties About Selected Team
$team = Get-MgTeam -TeamId $group.Id

$team | Select-Object *

#View All Members of a Team

$team = Get-MgTeam -TeamId $group.Id

$members = Get-MgTeamMember -TeamId $team.Id

$members | Select-Object DisplayName

#Create a New Group Then Convert to a Team
$group = New-MgGroup -DisplayName "New Group" -MailEnabled:$False -MailNickName "newgroup" -GroupTypes "Unified" -SecurityEnabled

#Create a New Team
#Using Namespace Microsoft.Graph.PowerShell.Models

[MicrosoftGraphTeam1]@{
Template = [MicrosoftGraphTeamsTemplate]@{
Id = 'com.microsoft.teams.template.OrganizeHelpDesk'
}
DisplayName = "New Team"
Description = "New Team Description"
} | New-MgTeam

$group = Get-MgGroup -Filter "DisplayName eq 'New Team'"

$team = Get-MgTeam -TeamId $group.Id


#Add a Team Owner
$group = Get-MgGroup -Filter "DisplayName eq 'New Team'"
$team = Get-MgTeam -TeamId $group.Id

$user = Get-MgUser -UserId "james.cook@tomsazure.ch"

$properties = @{
"@odata.type" = "#microsoft.graph.aadUserConversationMember";
"user@odata.bind" = "https://graph.microsoft.com/beta/users/" + $user.Id
}

$role = "owner"

New-MgTeamMember -TeamId $team.Id -Roles $role -AdditionalProperties $properties

#Add a Private Teams Channel Then Add a Member
$channel = New-MgTeamChannel -TeamId $team.Id -DisplayName "New Team Channel 2" -Description "New Team Channel Description 2" -MembershipType "Private"

$user = Get-MgUser -UserId "james.cook@tomsazure.ch"

$properties = @{
"@odata.type" = "#microsoft.graph.aadUserConversationMember";
"user@odata.bind" = "https://graph.microsoft.com/beta/users/" + $user.Id
}