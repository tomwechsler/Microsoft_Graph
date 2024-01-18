#Install the Microsoft Graph PowerShell SDK module
Install-Module Microsoft.Graph -Verbose -AllowClobber -Force

#Authenticate with your Entra ID account
Connect-MgGraph -Scope 'Application.ReadWrite.All'

#Get the current date
$currentDate = Get-Date

#Get all app registrations
$appRegistrations = Get-MgApplication -All

#Create an array to store the output
$output = @()

#Loop through each app registration
foreach ($app in $appRegistrations) {
    #Get all secrets for the app registration
    $secrets = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/applications/$($app.Id)/passwordCredentials"

    #Loop through each secret
    foreach ($secret in $secrets.Value) {
        #Check if endDateTime is not null
        if ($null -ne $secret.endDateTime) {
            #Calculate the number of days until the secret expires
            $daysUntilExpiry = ($secret.endDateTime - $currentDate).Days

            #Check if the secret expires in the next 10 days
            if ($daysUntilExpiry -le 10) {
                #Add the app registration and secret details to the output array
                $output += New-Object PSObject -Property @{
                    "App Name" = $app.DisplayName
                    "Secret KeyId" = $secret.KeyId
                    "Days Until Expiry" = $daysUntilExpiry
                }
            }
        }
    }
}

#Sort the output by the "Days Until Expiry" property and output in a table format
$output | Sort-Object "Days Until Expiry" -Descending | Format-Table

################################
#Export the output to a CSV file
################################

#Get the current date
$currentDate = Get-Date

#Get all app registrations
$appRegistrations = Get-MgApplication -All

#Create an array to store the output
$output = @()

#Loop through each app registration
foreach ($app in $appRegistrations) {
    #Get all secrets for the app registration
    $secrets = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/applications/$($app.Id)/passwordCredentials"

    #Loop through each secret
    foreach ($secret in $secrets.Value) {
        #Check if endDateTime is not null
        if ($null -ne $secret.endDateTime) {
            #Calculate the number of days until the secret expires
            $daysUntilExpiry = ($secret.endDateTime - $currentDate).Days

            #Check if the secret expires in the next 10 days
            if ($daysUntilExpiry -le 10) {
                #Add the app registration and secret details to the output array
                $output += New-Object PSObject -Property @{
                    "App Name" = $app.DisplayName
                    "Secret KeyId" = $secret.KeyId
                    "Days Until Expiry" = $daysUntilExpiry
                }
            }
        }
    }
}

#Export the output array to a CSV file
$output | Export-Csv -Path "ExpiringSecrets.csv" -NoTypeInformation