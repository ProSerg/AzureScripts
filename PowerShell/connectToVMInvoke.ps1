$username = 'devops'
$pass = ConvertTo-SecureString -string 'FktPoIeG1wnt' -AsPlainText -Force
$cred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $username, $pass
$s = New-PSSession -ConnectionUri 'http://40.115.25.30:5985' -Credential $cred -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck)
Invoke-Command -Session $s -ScriptBlock {Get-Process PowerShell}