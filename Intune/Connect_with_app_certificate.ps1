#The detailed instructions can be found in the file IntuneGraphAppCert.md

$certName = 'IntuneGraphAppCert'

$cert = New-SelfSignedCertificate -Subject "CN=$certName" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256 -NotAfter (get-date).AddYears(1)

Export-Certificate -Cert $cert -FilePath "C:\certs\$certName.cer"

$TenantId = '77e01716-a6a2-4f99-b864-xxxxxxxxxxxx'
$AppId = '5c14b994-2290-4f84-9069-xxxxxxxxxxxx'
$certName = 'IntuneGraphAppCert'

$Cert = Get-ChildItem -Path 'Cert:\CurrentUser\My' | Where-Object { $_.Subject -eq "CN=$CertName" }

Connect-MgGraph -TenantId $TenantId -ClientId $AppId -Certificate $Cert 

#We check the permissions
(Get-MgContext).Scopes