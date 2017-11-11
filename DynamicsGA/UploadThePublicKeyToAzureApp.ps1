
Connect-AzureAD
$applicationObjectId = "b8cddd4c-3f23-4450-adc8-0c7d0fd1979b"
 
$certificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 
 
$certificate.Import("C:\Amol\myassistcert.cer") 
 
$certKeyId = [Guid]::NewGuid().ToString("N") 
$certBase64Value = [System.Convert]::ToBase64String($certificate.GetRawCertData()) 
$certBase64Thumbprint = [System.Convert]::ToBase64String($certificate.GetCertHash()) 
$keyCred = New-AzureADApplicationKeyCredential -ObjectId $applicationObjectId -CustomKeyIdentifier "$certKeyId" -Type AsymmetricX509Cert -Usage Verify -Value $certBase64Value -StartDate $certificate.NotBefore -EndDate $certificate.NotAfter 
$keyCred | select * 

$text | Set-Content 'C:\Amol\key.txt'
