# Connect securely to Intune with Microsoft Graph and PowerShell!
In this example, we use an app registration in Microsoft Entra ID and a certificate created on the local machine.

## Create and export the certificate

**I use Visual Studio Code and PowerShell 7**  

```
$certName = 'IntuneGraphAppCert'

$cert = New-SelfSignedCertificate -Subject "CN=$certName" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256 -NotAfter (get-date).AddYears(1)

Export-Certificate -Cert $cert -FilePath "C:\certs\$certName.cer"
```

> Note: The certificate is created in the local certificate store and exported to the folder C:\certs. The certificate is valid for one year.

<img src="/Intune/Images/Example_1.png" alt="The Certificate">

## Create an app registration in Microsoft Azure AD

1. Go to the Azure portal and create a new app registration in Azure AD.

<img src="/Intune/Images/Example_2.png" alt="In the Entra ID">

2. Give the app a name and notice the following.

<img src="/Intune/Images/Example_3.png" alt="The ID's">

4. Go to the API permissions and add the following permissions.

<img src="/Intune/Images/Example_4.png" alt="The API permissions">

5. Do not forget to grant admin consent.

<img src="/Intune/Images/Example_5.png" alt="The admin consent">

6. Go to the certificate and secrets and upload the certificate.

<img src="/Intune/Images/Example_6.png" alt="The certificate">

## Back in PowerShell

1. Install the Microsoft.Graph.

```
Install-Module -Name Microsoft.Graph -Verbose -Force -AllowClobber
```

2. Import the Microsoft.Graph module.

```
Import-Module Microsoft.Graph
```

3. Create some variables.

```
$TenantId = '77e01716-a6a2-4f99-b864-xxxxxxxxxxxx'
$AppId = '5c14b994-2290-4f84-9069-xxxxxxxxxxxx'
$certName = 'IntuneGraphAppCert'

$Cert = Get-ChildItem -Path 'Cert:\CurrentUser\My' | Where-Object { $_.Subject -eq "CN=$CertName" }
```

4. Connect to Microsoft Graph.

```
Connect-MgGraph -TenantId $TenantId -ClientId $AppId -Certificate $Cert
```

5. We check the permissions
```
(Get-MgContext).Scopes
```

---
## *HAPPY CONNECTING!*
---