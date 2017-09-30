$Scripts ={
# Begin Script Block
    param ($ServerName)
    
    $SiteName = "Test"
    $SitePath ="IIS:\sites\" + $SiteName
    
    $WebsiteFolder = "C:\Website"
    
    $MonitoringSite = "C:\monitoring"
    
    $envVars =@( 
            @{name='PYTHONPATH';value=$WebsiteFolder},
            @{name='SP_ENV';value='PROD'},
            @{name='WSGI_HANDLER';value='web.app'}
          )
    $PyPath="C:\Python\Python.exe"
    
    $m = "<html><head></head><body>Monitor Page for Inside Track to ensure device is active for laod balancer.</body></html>"
    $p=   $MonitoringSite,"\Monitor.htm"
    #Create a monitor file
    New-Item $p -type file -force -value $m 
    $features = @(
       "Web-WebServer",
       "Web-Static-Content",
       "Web-Http-Errors",
       "Web-Http-Redirect",
       "Web-Stat-Compression",
       "Web-Filtering",
       "Web-Asp-Net45",
       "Web-Net-Ext45",
       "Web-ISAPI-Ext",
       "Web-ISAPI-Filter",
       "Web-Mgmt-Console",
       "Web-Mgmt-Tools",
       "NET-Framework-45-ASPNET",
       "Web-Mgmt-Service",
       "Web-Windows-Auth",
       "Web-CGI",
       "Web-Dyn-Compression",
       "Web-Scripting-Tools",
       "Web-Dyn-Compression"
    )
    # Add Windows Features 
    add-WindowsFeature $features -Verbose
    # block app install
    #choco install -y Git
    #choco install -y Python
    
    Import-Module WebAdministration
    #Configure default website
    # Add binding for all IP addresses of the server    
    foreach ($i in [System.Net.Dns]::GetHostAddresses($env:COMPUTERNAME)) {    
    
        $ip =$i.IPAddressToString
        if ($i.AddressFamily -eq 'InterNetworkV6') {
            $ip = "[$ip]"
        }
        New-WebBinding  -Name 'Default Web Site'  -IPAddress "$ip" -Port "80"
    }
    # Create directory for Monitoring site      
    if (!(Test-Path $MonitoringSite -PathType Container)) {
        New-Item -ItemType Directory -Path $MonitoringSite
    }
    #Add virtual directory for monitoring
    New-WebVirtualDirectory -Name monitoring  -PhysicalPath c:\Website -Site "Default Web Site"
    #Create directory for the Website
    if (!(Test-Path $WebsiteFolder -PathType Container)) {
        New-Item -ItemType Directory -Path $WebsiteFolder
        #Clone git repo
        #git clone 'https://github.comcast.com/Descartes/SuggestionPortal'
    }
 
    # Add a new website if it does not exist
    if ( (get-website | where-object { $_.name -eq  $SiteName }) -eq  $null ) {
         New-Website -Name $SiteName -ApplicationPool DefaultAppPool -PhysicalPath $WebsiteFolder
    } else{
    
        # Update 
    }
 
    #Set the bindings for the site with the servername.domain
    Set-ItemProperty  $SiteName -name bindings -value @{protocol="http";bindingInformation= ":80:$ServerName.$env:USERDNSDOMAIN"}
    Set-ItemProperty  $SiteName  -name bindings -value @{protocol="http";bindingInformation= ":80:$ServerName"}
    # Set the bindings for all IP address   
    $ips = [System.Net.Dns]::GetHostAddresses($env:COMPUTERNAME) | foreach {
     Set-ItemProperty  $SiteName  -name bindings -value @{protocol="http";bindingInformation= ":80:$_.IPAddressToString"}
     }
   # Add FastCGI handler 
   New-WebHandler -Name "FastCGI" -Path "*.php" -Verb "GET,POST" -Modules FastCgiModule -PSPath $Site -ScriptProcessor $PyPath -ResourceType "File" 
   ADD-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.webServer/fastCgi" -name "." -value @{fullPath=$PyPath; arguments="$WebsiteFolder\wfastcgi.py"}
   
   ADD-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST'  -filter "system.webServer/fastCgi/application[@fullPath='$PyPath']/environmentVariables" -name "." -value $envVars
 
    IISReset
    Start-Website -Name 'Default Web Site'
    Start-Website -Name 'Test'
# End Script Block
}
$ServerName = 'servername'
Invoke-Command  -Authentication Default -ComputerName $ServerName -ScriptBlock $Scripts -ArgumentList $ServerName
