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

#Connect to Graph
Connect-MgGraph -Scopes $scopes

#List the groups
Get-MgGroup | Format-List Id, DisplayName, Description, GroupTypes

$group = Get-MgGroup -Filter "DisplayName eq 'Cardano'"

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