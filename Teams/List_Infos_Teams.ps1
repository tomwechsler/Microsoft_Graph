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

#Create a new team
$params = @{ 
    "Template@odata.bind" = "https://graph.microsoft.com/v1.0/teamsTemplates('standard')" 
    DisplayName = 'Marketing' 
    Description = 'Team for the marketing' 
    } 
    New-MgTeam -BodyParameter $params

#Did it work?
Get-MgTeam

#Lets update some properties
$params = @{ 
    MemberSettings = @{ 
    AllowCreateUpdateChannels = "true" #<TrueOrFalse> 
    } 
    MessagingSettings = @{ 
    AllowUserEditMessages = "true" #<TrueOrFalse> 
    AllowUserDeleteMessages = "false" #<TrueOrFalse> 
    } 
    FunSettings = @{ 
    AllowGiphy = "true" #<TrueOrFalse> 
    GiphyContentRating = "moderate" #<ModerateOrStrict> 
    } 
    } 

 Update-MgTeam -TeamId 97d4ea74-1b57-4457-b172-182d7a5d5aa5 -BodyParameter $params

#Did it work?
Get-MgTeam -TeamId 97d4ea74-1b57-4457-b172-182d7a5d5aa5 | Select-Object -Property FunSettings -ExpandProperty FunSettings