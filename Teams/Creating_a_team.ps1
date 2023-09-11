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

#Retrieve Microsoft 365 Group and Team
$group = Get-MgGroup -Filter "DisplayName eq 'Cardano'"

Get-MgTeam -TeamId $group.Id

#Create a New Team
New-MgTeam -AdditionalProperties @{
    "template@odata.bind" = "https://graph.microsoft.com/v1.0/teamsTemplates('standard')";
    "displayName" = "Ethereum";
    "description" = "Ethereum Team";
}

#List the new Microsoft Team
$group = Get-MgGroup -Filter "DisplayName eq 'Ethereum'"

Get-MgTeam -TeamId $group.Id
