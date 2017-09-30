Set-ExecutionPolicy UnRestricted; 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); 
choco install git -y --no-progress
choco install microsoft-visual-cpp-build-tools -y --no-progress