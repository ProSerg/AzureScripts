Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Get-Module PowerShellGet -list | Select-Object Name,Version,Path
Install-Module -Force AzureRM 
Install-Module -Force Azure
Import-Module AzureRM
Import-Module Azure

Get-Module AzureRM -list | Select-Object Name,Version,Path

