#Retrieve Site
Get-MgSite -SiteId root 

#Search for Sites
Get-MgSite -Search "Cardano" | Select-Object DisplayName, Description, WebUrl

#Retrieve Site Columns
Get-MgSite -Search "Traders"
$site = Get-MgSite -Search "Traders" -Top 1
Get-MgSiteColumn -SiteId $site.Id | Select-Object DisplayName

#Retrieve Site Lists
$site = Get-MgSite -Search "Traders" -Top 1 
Get-MgSiteList -SiteId $site.Id