$username = 'developer@vrconcept.net'
$pass = ConvertTo-SecureString -string '5n6ttf_xGXFO' -AsPlainText -Force
$publicIP = "40.115.25.30" 
$cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username, $pass
Enter-PSSession -ComputerName 40.115.25.30 -Credential $cred