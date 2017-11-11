#Powershell Script #2:

$applicationObjectId = "24bd8347-67d2-4bbf-a2dc-673d1d25ea51"
$certificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 
$certificate.Import("C:\Amol\myassistcert.cer") 
$certKeyId = [Guid]::NewGuid().ToString("N") 
$certBase64Value = [System.Convert]::ToBase64String($certificate.GetRawCertData()) 
$certBase64Thumbprint = [System.Convert]::ToBase64String($certificate.GetCertHash()) 
$keyCred = New-AzureADApplicationKeyCredential -ObjectId $applicationObjectId -CustomKeyIdentifier "$certKeyId" -Type AsymmetricX509Cert -Usage Verify -Value $certBase64Value -StartDate $certificate.NotBefore -EndDate $certificate.NotAfter 
$keyCred | select * 
