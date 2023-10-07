#The detailed instructions can be found in the file IntuneGraphAppCert.md

$certName = 'IntuneGraphAppCert'

$cert = New-SelfSignedCertificate -Subject "CN=$certName" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256 -NotAfter (get-date).AddYears(5)

Export-Certificate -Cert $cert -FilePath "C:\certs\$certName.cer"

$TenantId = '6e58ed26-175b-4b81-ae01-d9f865953b07'
$AppId = '85a1ea9f-28d7-450a-be96-8f1e788c7396'
$certName = 'IntuneGraphAppCert'

$Cert = Get-ChildItem -Path 'Cert:\CurrentUser\My' | Where-Object { $_.Subject -eq "CN=$CertName" }

Connect-MgGraph -TenantId $TenantId -ClientId $AppId -Certificate $Cert 

