#To make some space below
Set-Location C:\
Clear-Host

#Istall the module. (You need admin on the machine.)
Install-Module Microsoft.Graph -AllowClobber -Verbose -Force

#Search for specific cmdlets
get-command *get-mgdevice*

#Set the variable with the tenant ID
$TenantID = "your Tenant ID"

#Connect to the graph
$Tenant = Connect-MgGraph -TenantId $TenantID -Scopes "AuditLog.Read.All","Directory.Read.All"

#Get a list of all devices
Get-MgDevice

#Get-Member to see the properties
Get-MgDevice | Get-Member

#Get a list of all devices and select the properties
Get-MgDevice | Select-Object DisplayName, EnrollmentProfileName, ApproximateLastSignInDateTime, DeviceId

#Get Infos about a specific device
Get-MgDeviceByDeviceId -DeviceId 88069fe5-367d-4cbd-be38-1c7b73740fcd | Select-Object *

#Add more permissions to the connection
$Tenant = Connect-MgGraph -TenantId $TenantID -Scopes "AuditLog.Read.All","Directory.Read.All", "DeviceManagementApps.Read.All", "DeviceManagementApps.ReadWrite.All"

#Get a list of the Audit events
Get-MgDeviceManagementAuditEvent

#Get a list of the Audit events and select the properties
Get-MgDeviceManagementAuditEvent | Select-Object Category, ActivityDateTime, ActivityResult, ComponentName, Id | Format-Table -AutoSize

#Get all detected apps
$detectedApps = Get-MgDeviceManagementDetectedApp

#Output detected apps
Write-Output "Detected Apps:" $detectedApps

#Get all device compliance policies
$deviceCompliancePolicies = Get-MgDeviceManagementDeviceCompliancePolicy

# Output device compliance policies
Write-Output "Device Compliance Policies:" $deviceCompliancePolicies

# Get all IoT update statuses
$ioUpdateStatuses = Get-MgDeviceManagementIoUpdateStatus 

# Output IoT update statuses
Write-Output "IoT Update Statuses:" $ioUpdateStatuses

#Get all managed devices
$managedDevices = Get-MgDeviceManagementManagedDevice

#Output managed devices
Write-Output "Managed Devices:" $managedDevices

#Get all managed device overviews
$managedDeviceOverviews = Get-MgDeviceManagementManagedDeviceOverview 

#Output managed device overviews
Write-Output "Managed Device Overviews:" $managedDeviceOverviews

#Add more permissions to the connection
$Tenant = Connect-MgGraph -TenantId $TenantID -Scopes "AuditLog.Read.All","Directory.Read.All", "DeviceManagementApps.Read.All", "DeviceManagementApps.ReadWrite.All", "DeviceManagementRBAC.Read.All", "DeviceManagementRBAC.ReadWrite.All"

#Get all resource operations
$resourceOperations = Get-MgDeviceManagementResourceOperation

#Output resource operations
Write-Output "Resource Operations:" $resourceOperations

#Get all role definitions
$roleDefinitions = Get-MgDeviceManagementRoleDefinition

#Output role definitions
$roleDefinitions | Select-Object DisplayName, Description

#Get all managed app policies
$managedAppPolicies = Get-MgDeviceAppManagementManagedAppPolicy 

#Output managed app policies
Write-Output "Managed App Policies:" $managedAppPolicies

#Get Device Maangement Configuration
Get-MgDeviceManagementDeviceConfiguration

Get-MgDeviceManagementDeviceConfiguration -Filter "startswith(DisplayName,'Config')" | Select-Object DisplayName,Id

Get-MgDeviceManagementDeviceConfiguration -Filter "startswith(DisplayName,'Config')" | Select-Object DisplayName,Id | Out-GridView