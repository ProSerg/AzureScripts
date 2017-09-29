FROM microsoft/iis

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN Set-ExecutionPolicy UnRestricted; \
	iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); 

RUN choco install git -y --no-progress
RUN choco install microsoft-visual-cpp-build-tools -y --no-progress

ENV PYTHON_VERSION 3.6.2
ENV PYTHON_RELEASE 3.6.2

RUN $url = ('https://www.python.org/ftp/python/{0}/python-{1}-amd64.exe' -f $env:PYTHON_RELEASE, $env:PYTHON_VERSION); \
	Write-Host ('Downloading {0} ...' -f $url); \
	(New-Object System.Net.WebClient).DownloadFile($url, 'python.exe'); \
	\
	Write-Host 'Installing ...'; \
# https://docs.python.org/3.5/using/windows.html#installing-without-ui
	Start-Process python.exe -Wait \
		-ArgumentList @( \
			'/quiet', \
			'InstallAllUsers=1', \
			'TargetDir=C:\Python', \
			'PrependPath=1', \
			'Shortcuts=0', \
			'Include_doc=0', \
			'Include_pip=0', \
			'Include_test=0' \
		); \
	\
# the installer updated PATH, so we should refresh our local value
	$env:PATH = [Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::Machine); \
	\
	Write-Host 'Verifying install ...'; \
	Write-Host '  python --version'; python --version; \
	\
	Write-Host 'Removing ...'; \
	Remove-Item python.exe -Force; \
	\
	Write-Host 'Complete.';

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 9.0.1

RUN Write-Host ('Installing pip=={0} ...' -f $env:PYTHON_PIP_VERSION); \
	(New-Object System.Net.WebClient).DownloadFile('https://bootstrap.pypa.io/get-pip.py', 'get-pip.py'); \
	python get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		('pip=={0}' -f $env:PYTHON_PIP_VERSION) \
	; \
	Remove-Item get-pip.py -Force; \
	\
	Write-Host 'Verifying pip install ...'; \
	pip --version; \
	\
	Write-Host 'Complete.';



CMD ["python"]

#RUN powershell -NoProfile -Command \
#	pip install wfastcgi
	
# RUN pip install --no-cache-dir virtualenv

#RUN powershell -NoProfile -Command \
#	pip install django
#RUN powershell -NoProfile -Command \
#	pip install wagtail
#RUN powershell -NoProfile -Command \
#	pip install django_compressor

#RUN powershell -NoProfile -Command \
#	pip install django-crispy-forms

#RUN powershell -NoProfile -Command \
#	pip install django-registration

RUN choco install postgresql --version 9.1.3

RUN git clone https://github.com/nescode/wagtailcmsdemo.git
RUN cd wagtailcmsdemo; \ 
	pip install -r requirements.txt; \
	python manage.py migrate; \
	python manage.py 0.0.0.0:8000;

EXPOSE 8000