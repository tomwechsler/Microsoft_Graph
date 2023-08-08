#Reading subscription license plans requires the Organization.Read.All
Connect-Graph -Scopes Organization.Read.All

#To view summary information about your current licensing plans
Get-MgSubscribedSku | Select-Object -Property Sku*, ConsumedUnits -ExpandProperty PrepaidUnits | Format-List

#The results contain:

#SkuPartNumber: Shows the available licensing plans for your organization. For example, ENTERPRISEPACK is the license plan name for Office 365 Enterprise E3.

#Enabled: Number of licenses that you've purchased for a specific licensing plan.

#ConsumedUnits: Number of licenses that you've assigned to users from a specific licensing plan.

#To view details about the Microsoft 365 services that are available in all of your license plans, first display a list of your license plans.
Get-MgSubscribedSku

#Next, store the license plans information in a variable.
$licenses = Get-MgSubscribedSku

#Next, display the services in a specific license plan.
$licenses[<index>].ServicePlans
#<index> is an integer that specifies the row number of the license plan from the display of the Get-MgSubscribedSku | Select SkuPartNumber command, minus 1.

Get-MgSubscribedSku | Select-Object SkuPartNumber

#Then the command to display the services for the ENTERPRISEPREMIUM license plan is this:

#SkuPartNumber
#-------------
#Microsoft_Intune_Suite
#ENTERPRISEPREMIUM

$licenses[1].ServicePlans