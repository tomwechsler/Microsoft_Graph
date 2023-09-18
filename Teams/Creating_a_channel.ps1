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

#Create a Team Channel
$group = Get-MgGroup -Filter "DisplayName eq 'Ethereum'" 

$team = Get-MgTeam -TeamId $group.Id

$channelname = "Traders"
$channeldescription = "Ethereum Traders"

$channel = New-MgTeamChannel -TeamId $team.Id -DisplayName $channelname -Description $channeldescription

#List the new Team Channel
Get-MgTeamChannel -TeamId $team.Id -ChannelId $channel.Id