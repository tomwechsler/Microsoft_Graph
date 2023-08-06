#Viewing Existing Connection Details

#If needed
Import-Module Microsoft.Graph

#Connect to Microsoft 365 to Access Users and Groups
Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"

#Connections
#Scopes are required for each connection
#Scope permissions are for the current session (unless using an Azure App Registration)
#Extra needed permissions require re-connecting with the specified scopes

#View Current Connection Details
Get-MgContext
(Get-MgContext).AuthType
(Get-MgContext).Scopes

#Reconnect Connection With Updated Scopes
#Original Connection
Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All"

#Update Connection to Allow "Group Members"
Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All","GroupMember.ReadWrite.All"