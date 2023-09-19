#Install the Microsoft Graph PowerShell SDK module
Install-Module Microsoft.Graph

#Install the Az PowerShell module
Install-Module Az -AllowClobber -Force -Verbose

# Authenticate with your Azure AD account
Connect-MgGraph -Scopes 'Application.Read.All','AppRoleAssignment.ReadWrite.All'

#Connect to Azure
Connect-AzAccount

#Get all user assigned managed identities in your tenant
$UserAssignedManagedIdentities = Get-MgServicePrincipal -Filter "Tags/any(t:t eq 'WindowsAzureActiveDirectoryIntegratedApp')"

#For each user assigned managed identity, check if it is assigned to a resource
foreach ($UserAssignedManagedIdentity in $UserAssignedManagedIdentities) {
    # Get the resource ID of the user assigned managed identity
    $UserAssignedManagedIdentityResourceId = $UserAssignedManagedIdentity.AppId

    #Get all resources
    $Resources = Get-AzResource

    #Filter resources that have an identity
    $ResourcesWithIdentity = $Resources | Where-Object {$_.Identity -ne $null}

    #Search for all resources using this user assigned managed identity
    $ResourcesUsingUserAssignedManagedIdentity = $ResourcesWithIdentity | Where-Object {$_.Identity.UserAssignedIdentities.Keys -contains $UserAssignedManagedIdentityResourceId}

    #If no resource is found, add the user assigned managed identity to the list
    if ($ResourcesUsingUserAssignedManagedIdentity.Count -eq 0) {
        $UnusedUserAssignedManagedIdentities += $UserAssignedManagedIdentity
    }
}

# Output the number and names of the unused user assigned managed identities.
Write-Host "There are $($UnusedUserAssignedManagedIdentities.Count) unused user assigned managed identities in your tenant:"
foreach ($UnusedUserAssignedManagedIdentity in $UnusedUserAssignedManagedIdentities) {
    Write-Host "- $($UnusedUserAssignedManagedIdentity.DisplayName)"
}