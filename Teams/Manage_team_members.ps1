#Core Connection for Managing Teams
$scopes = @(
    "Team.Create" 
    "TeamSettings.ReadWrite.All" 
    "TeamsTab.ReadWrite.All" 
    "TeamsTab.Create" 
    "TeamMember.ReadWrite.All" 
    "Group.ReadWrite.All" 
    "GroupMember.ReadWrite.All"
)
Connect-MgGraph -Scopes $scopes

#Retrieve User Details
$email = "james.west@tomsazure.ch"
$user = Get-MgUser -UserId $email

#Retrieve Team and Add an Owner
$group = Get-MgGroup -Filter "DisplayName eq 'Ethereum'" 

$team = Get-MgTeam -TeamId $group.Id

$ownerproperties = @{
    "@odata.type" = "#microsoft.graph.aadUserConversationMember";
    "user@odata.bind" = "https://graph.microsoft.com/beta/users/" + $user.Id }

$role = "owner"

New-MgTeamMember -TeamId $team.Id -Roles $role -AdditionalProperties $ownerproperties

#Retrieve Team Member and Owner for the Team
Get-MgTeamMember -TeamId $team.Id | Select-Object -Property Roles,DisplayName