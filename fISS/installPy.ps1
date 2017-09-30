Set-ExecutionPolicy UnRestricted; 

$env:PYTHON_VERSION = "3.6.2"
$env:PYTHON_RELEASE = "3.6.2"
$env:PYTHON_PIP_VERSION = "9.0.3"


$url = ('https://www.python.org/ftp/python/{0}/python-{1}-amd64.exe' -f $env:PYTHON_RELEASE, $env:PYTHON_VERSION);
Write-Host ('Downloading {0} ...' -f $url);

(New-Object System.Net.WebClient).DownloadFile($url, 'python.exe');
if($?)
{
   	Write-Host 'Done ... ';
}
else
{
   	exit 1
}

Write-Host 'Installing ...';
# https://docs.python.org/3.5/using/windows.html#installing-without-ui
Start-Process python.exe -Wait -ArgumentList @( 
			'/quiet', 
			'InstallAllUsers=1', 
			'TargetDir=C:\Python',
			'PrependPath=1',
			'Shortcuts=0',
			'Include_doc=0',
			'Include_pip=0',
			'Include_test=0'
        );
if($?)
{
   	Write-Host 'Done ... ';
}
else
{
   	exit 1
}


		
# the installer updated PATH, so we should refresh our local value
$env:PATH = [Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::Machine); 
Write-Host 'Verifying install ...'; 
Write-Host ' python --version'; 
python --version; 

if($?)
{
   	Write-Host 'Done ... ';
}
else
{
   	exit 1
}

Write-Host 'Removing ...'; 
Remove-Item python.exe -Force; 
Write-Host 'Complete.';


Write-Host ('Installing pip=={0} ...' -f $env:PYTHON_PIP_VERSION);
(New-Object System.Net.WebClient).DownloadFile('https://bootstrap.pypa.io/get-pip.py', 'get-pip.py');
if($?)
{
   	Write-Host 'Done ... ';
}
else
{
   	exit 1
}

python get-pip.py --disable-pip-version-check --no-cache-dir ('pip=={0}' -f $env:PYTHON_PIP_VERSION); 
if($?)
{
   	Write-Host 'Done ... ';
}
else
{
   	exit 1
}

Remove-Item get-pip.py -Force; 
Write-Host 'Verifying pip install ...';
pip --version;
if($?)
{
   	Write-Host 'Done ... ';
}
else
{
   	exit 1
}

Write-Host 'Complete.';