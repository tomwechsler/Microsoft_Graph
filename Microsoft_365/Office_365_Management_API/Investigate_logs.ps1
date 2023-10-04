#https://learn.microsoft.com/en-us/office/office-365-management-api/get-started-with-office-365-management-apis

#First create an Azure App Registration in the Entra Admin Center
#For the investigation we need an Azure App Registration with the following permissions:
#Office 365 Management APIs > ActivityFeed.Read
#Office 365 Management APIs > ActivityFeed.ReadDlp
#Office 365 Management APIs > ServiceHealth.Read (Optinal)

#Do not forget to grant admin consent for the permissions

#Set Variables
$ClientID = "<Client ID>"
$ClientSecret = "<Client Secret>"
$tenantdomain = "<Domain>.onmicrosoft.com"
$TenantGUID = "<Tenant ID>"
$loginURL = "https://login.microsoftonline.com/"
$resource = "https://manage.office.com"

$body = @{grant_type="client_credentials";resource=$resource;client_id=$ClientID;client_secret=$ClientSecret}
$oauth = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantdomain/oauth2/token?api-version=1.0 -Body $body
$headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"} 

#Get Subscription Status
Invoke-WebRequest -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/list"

#Start Subscriptions
Invoke-WebRequest -Method Post -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/start?contentType=Audit.AzureActiveDirectory"

Invoke-WebRequest -Method Post -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/start?contentType=Audit.SharePoint"

Invoke-WebRequest -Method Post -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/start?contentType=Audit.General"

Invoke-WebRequest -Method Post -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/start?contentType=Audit.Exchange"

##########
#EXAMPLE 1
##########

#Retrieve Items from Audit.AzurectiveDirectory
Invoke-WebRequest -Method GET -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/content?contentType=Audit.AzureActiveDirectory"

#Perform a Date Range Query
$startTimeDt = "2023-10-02T05:00:00.000Z"
$endTimeDt = "2023-10-02T21:00:10.123Z"

$response = Invoke-WebRequest -Method GET -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/content?startTime=$startTimeDt&endTime=$endTimeDt&contentType=Audit.AzureActiveDirectory&PublisherIdentifier=$TenantGUID"

#View Response
$response | Select-Object -ExpandProperty Content

#Loop All Items and View Actual Records
$contentResult = $response.Content | ConvertFrom-Json
foreach ($contentItem in $contentResult) {
    $blobUri = $contentItem.contentUri
    try {
        $blobResponse = Invoke-WebRequest -Method Get -Headers $headerParams -Uri $blobUri
        $results = $blobResponse.Content | ConvertFrom-Json
        Write-Output $results
    }
    catch {
        Write-Error $_.Exception.Message
    }
}

#List specific properties
$contentResult = $response.Content | ConvertFrom-Json
$table = @()
foreach ($contentItem in $contentResult) {
    $blobUri = $contentItem.contentUri
    try {
        $blobResponse = Invoke-WebRequest -Method Get -Headers $headerParams -Uri $blobUri
        $results = $blobResponse.Content | ConvertFrom-Json
        foreach ($result in $results) {
            $operation = $result.Operation
            $userID = $result.UserID
            $actorIPAddress = $result.ActorIPAddress
            $table += [pscustomobject]@{
                Operation = $operation
                UserID = $userID
                ActorIPAddress = $actorIPAddress
            }
        }
    }
    catch {
        Write-Error $_.Exception.Message
    }
}
$table | Format-Table

##########
#EXAMPLE 2
##########

# Replace these values with your own
$ClientID = "<Client ID>"
$ClientSecret = "<Client Secret>"
$tenantdomain = "<Domain>.onmicrosoft.com"
$TenantGUID = "<Tenant ID>"
$loginURL = "https://login.microsoftonline.com/"
$resource = "https://manage.office.com"

$body = @{grant_type="client_credentials";resource=$resource;client_id=$ClientID;client_secret=$ClientSecret}
$oauth = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantdomain/oauth2/token?api-version=1.0 -Body $body
$headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}

#Retrieve Items from Audit.SharePoint
Invoke-WebRequest -Method GET -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/content?contentType=Audit.General"

#Perform a Date Range Query
$startTimeDt = "2023-10-03T05:00:00.000Z"
$endTimeDt = "2023-10-03T21:00:10.123Z"

$response = Invoke-WebRequest -Method GET -Headers $headerParams -Uri "$resource/api/v1.0/$tenantGUID/activity/feed/subscriptions/content?startTime=$startTimeDt&endTime=$endTimeDt&contentType=Audit.General&PublisherIdentifier=$TenantGUID"

#View Response
$response | Select-Object -ExpandProperty Content

#Loop All Items and View Actual Records
$contentResult = $response.Content | ConvertFrom-Json
foreach ($contentItem in $contentResult) {
    $blobUri = $contentItem.contentUri
    try {
        $blobResponse = Invoke-WebRequest -Method Get -Headers $headerParams -Uri $blobUri
        $results = $blobResponse.Content | ConvertFrom-Json
        Write-Output $results
    }
    catch {
        Write-Error $_.Exception.Message
    }
}

#List specific properties
$contentResult = $response.Content | ConvertFrom-Json
foreach ($contentItem in $contentResult) {
    $blobUri = $contentItem.contentUri
    try {
        $blobResponse = Invoke-WebRequest -Method Get -Headers $headerParams -Uri $blobUri
        $results = $blobResponse.Content | ConvertFrom-Json | Select-Object CreationTime, Workload, ResultStatus
        $results | Format-Table
    }
    catch {
        Write-Error $_.Exception.Message
    }
}