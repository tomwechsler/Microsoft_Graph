#Authenticate with Microsoft Graph
Connect-MgGraph

#Get SuspiciousActivity alerts
$alerts = Get-MgSecurityAlert -Filter "Category eq 'SuspiciousActivity'"

foreach ($alert in $alerts) {
    Write-Host "Alert ID: $($alert.Id)"
    Write-Host "Title: $($alert.Title)"
    Write-Host "Description: $($alert.Description)"
    Write-Host "Status: $($alert.Status)"
    Write-Host "Severity: $($alert.Severity)"
    Write-Host "--------------------------"
}

#Get Malware alerts
$alerts = Get-MgSecurityAlert -Filter "Category eq 'Malware'"

foreach ($alert in $alerts) {
    Write-Host "Alert ID: $($alert.Id)"
    Write-Host "Title: $($alert.Title)"
    Write-Host "Description: $($alert.Description)"
    Write-Host "Status: $($alert.Status)"
    Write-Host "Severity: $($alert.Severity)"
    Write-Host "--------------------------"
}

#Get UnwantedSoftware alerts
$alerts = Get-MgSecurityAlert -Filter "Category eq 'UnwantedSoftware'"

foreach ($alert in $alerts) {
    Write-Host "Alert ID: $($alert.Id)"
    Write-Host "Title: $($alert.Title)"
    Write-Host "Description: $($alert.Description)"
    Write-Host "Status: $($alert.Status)"
    Write-Host "Severity: $($alert.Severity)"
    Write-Host "--------------------------"
}

#Get DefenseEvasion alerts
$alerts = Get-MgSecurityAlert -Filter "Category eq 'DefenseEvasion'"

foreach ($alert in $alerts) {
    Write-Host "Alert ID: $($alert.Id)"
    Write-Host "Title: $($alert.Title)"
    Write-Host "Description: $($alert.Description)"
    Write-Host "Status: $($alert.Status)"
    Write-Host "Severity: $($alert.Severity)"
    Write-Host "--------------------------"
}

#Get CommandAndControl alerts
$alerts = Get-MgSecurityAlert -Filter "Category eq 'CommandAndControl'"

foreach ($alert in $alerts) {
    Write-Host "Alert ID: $($alert.Id)"
    Write-Host "Title: $($alert.Title)"
    Write-Host "Description: $($alert.Description)"
    Write-Host "Status: $($alert.Status)"
    Write-Host "Severity: $($alert.Severity)"
    Write-Host "--------------------------"
}

#Disconnect from Microsoft Graph
Disconnect-MgGraph