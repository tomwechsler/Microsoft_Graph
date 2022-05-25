Set-Location C:\
Clear-Host

#If needed
Import-Module Microsoft.Graph

#Set the API to the 'beta' endpoint
Select-MgProfile -Name "beta"

#Connect for User Management:

#Read Only Connection
$scopes = @(
	"User.ReadBasic.All"
	"User.Read.All"
	"Directory.Read.All"
	)
Connect-MgGraph -Scopes $scopes

#Read and Write Connection
$scopes = @(
	"User.ReadWrite.All"
	"Directory.ReadWrite.All"
	)
Connect-MgGraph -Scopes $scopes

#Check the permissions
Get-MgContext | select -ExpandProperty scopes

#Retrieving User Accounts:

#Retrieve All Users
Get-MgUser | Format-List ID, DisplayName, Mail, UserPrincipalName

#Retrieve Specific User by ID
Get-MgUser -UserId 'f9c720a4-c7f1-4b00-b419-ff2c806e0ddf' | Format-List ID, DisplayName, Mail, UserPrincipalName

#Create a New User Account
$password = @{ Password= 'P@ssw0rd4625???' }
New-MgUser -DisplayName 'Timo Jones' -PasswordProfile $password -AccountEnabled -MailNickName 'timojones' -UserPrincipalName 'timo.jones@tomrocks.ch'

#Updating User Accounts

#Update User Using ID
Update-MgUser -UserId 'e0004b8a-b13f-4355-a291-4a7fef7d96df' -DisplayName 'Timo R Jones'

#Did it work
Get-MgUser -UserId 'e0004b8a-b13f-4355-a291-4a7fef7d96df'

#Retrieve User Using Filtering, Then Update
$user = Get-MgUser -ConsistencyLevel eventual -Filter "startsWith(UserPrincipalName, 'timo.jones@tomrocks.ch')"
Update-MgUser -UserId $user.Id -DisplayName 'Timo Jones'

#Did it work
Get-MgUser -UserId 'e0004b8a-b13f-4355-a291-4a7fef7d96df'

#Deleting User Accounts

#Remove User by ID
Remove-MgUser -UserId 'e0004b8a-b13f-4355-a291-4a7fef7d96df'

#Remove User by ID with Confirmation
Remove-MgUser -UserId 'e0004b8a-b13f-4355-a291-4a7fef7d96df' -Confirm

#Retrieve User Using Filtering, Then Delete
$user = Get-MgUser -ConsistencyLevel eventual -Filter "startsWith(UserPrincipalName, 'timo.jones@tomrocks.ch')"
Remove-MgUser -UserId $user.Id -Confirm

#Did it work
Get-MgUser -UserId 'e0004b8a-b13f-4355-a291-4a7fef7d96df'

#Connect for Group Management:

#Read Only Connection
$scopes = @("Group.Read.All")
Connect-MgGraph -Scopes $scopes

#Read and Write Connection
$scopes = @("Group.ReadWrite.All")
Connect-MgGraph -Scopes $scopes

#Read and Write Connection Including Group Memberships
$scopes = @(
	"Group.ReadWrite.All"
	"GroupMember.ReadWrite.All")
Connect-MgGraph -Scopes $scopes

#Check the permissions
Get-MgContext | select -ExpandProperty scopes

#Retrieving Groups:

#Retrieve All Groups
Get-MgGroup| Format-List ID, DisplayName, Description, GroupTypes

#Retrieve Specific Group by ID
Get-MgGroup -GroupId '12eda8b0-695b-4f57-a7b3-245b2a6552c9' | Format-List ID, DisplayName, Description, GroupTypes

#Retrieve Groups by Filtering
Get-MgGroup -ConsistencyLevel eventual -Filter "startsWith(DisplayName, 'Technik')"

#Creating Groups:

#Create a New Group
New-MgGroup -DisplayName 'MSGraph' -MailEnabled: $False -MailNickName 'MSGraph' -SecurityEnabled

#Updating Groups:

#Update Group Using ID
$properties = @{ 
	"Description" = "New MS Graph Group"
	"DisplayName" = "New MS Graph Group Description"
}
Update-MgGroup -GroupId 'b2af405b-1c46-46c2-be8e-5288bc9c7dc6' -BodyParameter $properties

#Did it work?
Get-MgGroup -GroupId 'b2af405b-1c46-46c2-be8e-5288bc9c7dc6'

#Deleting Groups:

#Remove Group by ID
Remove-MgGroup -GroupId 'b2af405b-1c46-46c2-be8e-5288bc9c7dc6'

#Remove Group by ID with Confirmation
Remove-MgGroup -GroupId 'b2af405b-1c46-46c2-be8e-5288bc9c7dc6' -Confirm

#Retrieve Group Using Filtering, Then Delete
$group = Get-MgGroup -ConsistencyLevel eventual -Filter "startsWith(DisplayName, 'New MS Graph Group Description')"
Remove-MgGroup -GroupId $group.Id -Confirm

#Did it work?
Get-MgGroup -GroupId 'b2af405b-1c46-46c2-be8e-5288bc9c7dc6'

#Modify Group Membership:

#Add a Group Member
$user = Get-MgUser -ConsistencyLevel eventual -Search '"DisplayName:Timo Meyer"'
$group = Get-MgGroup -GroupId 'be278623-1c0b-4c18-bb97-c617463ca920'

New-MgGroupMember -GroupId $group.Id -DirectoryObjectId $user.Id

#Did work?
Get-MgGroupMember -GroupId $group.Id