#Reading user properties including license details requires the User.Read.All
Connect-Graph -Scopes User.ReadWrite.All, Organization.Read.All

#Next, list the license plans for your tenant with this command.
Get-MgSubscribedSku

#Use these commands to list the services that are available in each licensing plan.
$allSKUs = Get-MgSubscribedSku -Property SkuPartNumber, ServicePlans 

$allSKUs | ForEach-Object {
    Write-Host "Service Plan:" $_.SkuPartNumber
    $_.ServicePlans | ForEach-Object {$_}
}

#Use these commands to list the licenses that are assigned to a user account.
Get-MgUserLicenseDetail -UserId "mike.braun@contoso.com"

#To view all the Microsoft 365 services that a user has access to
(Get-MgUserLicenseDetail -UserId "mike.braun@contoso.com" -Property ServicePlans).ServicePlans

(Get-MgUserLicenseDetail -UserId "mike.braun@contoso.com" -Property ServicePlans)[0].ServicePlans

#To view all the services for a user who has been assigned multiple licenses
$userUPN="mike.braun@contoso.com"

$allLicenses = Get-MgUserLicenseDetail -UserId $userUPN -Property SkuPartNumber, ServicePlans
$allLicenses | ForEach-Object {
    Write-Host "License:" $_.SkuPartNumber
    $_.ServicePlans | ForEach-Object {$_}
}