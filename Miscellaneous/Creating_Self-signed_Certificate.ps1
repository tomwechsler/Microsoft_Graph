#Create the Certificate
$cert = New-SelfSignedCertificate -Subject "CN={GraphCertificate}" -CertStoreLocation "Cert:\CurrentUser\My" `
    -KeyExportPolicy Exportable -KeySpec Signature `
    -KeyLength 4096 -KeyAlgorithm RSA -HashAlgorithm SHA256

#Export the Created Certificate
Export-Certificate -Cert $cert -FilePath "C:\Certs\{GraphCertificate}.cer"

#Set the Password and Export as "PFX"
$pwd = ConvertTo-SecureString -String "{Password}" -Force –AsPlainTextExport -PfxCertificate `
    -Cert $cert -FilePath "C:\Certs\{GraphCertificate}.pfx" -Password $pwd
