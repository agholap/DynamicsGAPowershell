#
#Set-ExecutionPolicy –ExecutionPolicy RemoteSigned –Scope CurrentUser
# Import Micrsoft.Xrm.Data.Powershell module 
#Import-Module Microsoft.Xrm.Data.Powershell
#Add-PSSnapin Microsoft.Xrm.Tooling.Connector
$CRMConn = Get-CrmConnection -InteractiveMode

#Get-Command *crm*
$users=Import-Csv "c:\Amol\approveEmail.csv"
foreach ($user in $users) 
{
Write-Output "Current User  $user"
$crmUser = Get-CrmRecords -conn $CRMConn -EntityLogicalName systemuser -FilterAttribute internalemailaddress -FilterOperator eq -FilterValue $user.Email -Fields systemuserid,fullname
# Get-CrmRecords -conn $conn -EntityLogicalName account -FilterAttribute name -FilterOperator "eq" -FilterValue "Adventure Works (sample)" -Fields name,accountnumber
  if($crmUser.CrmRecords.Count -eq 1)
  {
    Write-Output "System User Found, Approving"
    Approve-CrmEmailAddress  -conn $CRMConn -UserId $crmUser.CrmRecords[0].systemuserid
  }
  else
  {
  #search for queue
    Write-Output "Checking Queue"
   $crmQueue = Get-CrmRecords  -conn $CRMConn -EntityLogicalName queue -FilterAttribute emailaddress -FilterOperator "eq" -FilterValue $user.Email -Fields queueid
   if($crmQueue.CrmRecords.Count -eq 1)
  {
   Write-Output "Queue Found, Approving"
    Approve-CrmEmailAddress  -conn $CRMConn -conn $conn -QueueId crmQueue.CrmRecords[0].queueid
   }
  }
    
} 
# Get-Help *Crm*

#Get-Help Approve-CrmEmailAddress -Detailed