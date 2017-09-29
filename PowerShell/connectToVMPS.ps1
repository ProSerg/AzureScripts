Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
$subName = "Visual Studio Professional with MSDN"
$cloudService = "jakesNewService"
$vmName = "WinServer"
 
.\InstallWinRMCertAzureVM.ps1 -SubscriptionName $subName -ServiceName $cloudService -Name $vmName
  
 # Return back the correct URI for Remote PowerShell  
$uri = Get-AzureWinRMUri -ServiceName $cloudService -Name $vmName
  
# Credentials for the VM
$cred = Get-Credential  
  
# Open a New Remote PowerShell Session
Enter-PSSession -ConnectionUri $uri -Credential $cred
