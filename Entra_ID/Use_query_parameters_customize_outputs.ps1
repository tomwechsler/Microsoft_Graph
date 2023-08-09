#Count parameter
Get-MgUser -ConsistencyLevel eventual -Count userCount

$userCount

#Expand parameter
Get-MgGroup 

Get-MgGroup -GroupId '011368db-4b82-4dc4-a611-8dbb0e423686' -Expand members | 
  Select-Object -ExpandProperty members

Get-MgGroup -GroupId '011368db-4b82-4dc4-a611-8dbb0e423686' -Expand members | 
Select-Object -ExpandProperty members |
Select-Object -ExpandProperty Id

#Filter parameter
Get-MgUser -Filter "startsWith(DisplayName, 'J')"

#OrderBy parameter
Get-MgUser -OrderBy DisplayName

#Search parameter
Get-MgUser -ConsistencyLevel eventual -Count UserCount -Search '"DisplayName:St"'

#Select parameter
Get-MgUser | Select-Object Id, DisplayName

#Top parameter
Get-MgUser -Top 5

#Error handling for query parameters
Get-MgUser -Filter "Contains(DisplayName, 'Test')"

#Some requests will return an error message if a specified query parameter isn't supported. 
#For example, you can't use the -Contains operator on the DisplayName property.