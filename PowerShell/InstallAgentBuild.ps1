$ErrorActionPreference="Stop";
If(-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent() ).IsInRole( [Security.Principal.WindowsBuiltInRole] “Administrator”)) { 
    throw "Run command in Administrator PowerShell Prompt"
};

If(-NOT (Test-Path $env:SystemDrive\'vstsagent') ){
    mkdir $env:SystemDrive\'vstsagent'
}; 
cd $env:SystemDrive\'vstsagent'; 
for($i=1; $i -lt 100; $i++) {
    $destFolder="A"+$i.ToString();
    if(-NOT (Test-Path ($destFolder))) { 
            mkdir $destFolder;
            cd $destFolder;
            break;
        }
    }; 
$agentZip="$PWD\agent.zip";
(New-Object Net.WebClient).DownloadFile( 'https://github.com/Microsoft/vsts-agent/releases/download/v2.123.0/vsts-agent-win7-x64-2.123.0.zip', $agentZip);
Add-Type -AssemblyName System.IO.Compression.FileSystem;
[System.IO.Compression.ZipFile]::ExtractToDirectory( $agentZip, "$PWD");
.\config.cmd --deploymentgroup --agent $env:COMPUTERNAME --runasservice --work '_work' --url 'https://vrsearching.visualstudio.com/'  --projectname 'MediaFrop' --deploymentgroupname "FirstDeploymentGroup";
         
Remove-Item $agentZip;