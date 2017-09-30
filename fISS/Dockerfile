FROM microsoft/iis

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]
RUN Set-ExecutionPolicy UnRestricted;

RUN mkdir C:\Website
RUN mkdir C:\monitoring

# RUN mkdir C:\Website

# ADD space-science/ /site
ADD installApp.ps1 /Website
RUN powershell  /Website/installApp.ps1

ADD installPy.ps1 /Website
RUN powershell  /Website/installPy.ps1 

SHELL ["pwd"]

ADD configIIS.ps1 /Website
RUN powershell  /Website/configIIS.ps1

ADD deployAPP.ps1 /Website
RUN powershell  /Website/deployAPP.ps1



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

# Import-Module Install-Postgres
# Install-Postgres -User "postgres" -Password "ChangeMe!"
#Install-Postgres  
#-User "postgres"  
#-Password "ChangeMe!"  
#-InstallUrl "http://get.enterprisedb.com/postgresql/postgresql-9.3.5-1-windows-x64.exe"  
#-InstallPath "C:\Program Files\PostgreSQL\9.3"  
#-DataPath "C:\Program Files\PostgreSQL\9.3\data"  
#-Locale "Romanian, Romania"  
#-Port 5432  
#-ServiceName "postgresql"

#RUN git clone https://github.com/nescode/wagtailcmsdemo.git
#RUN cd wagtailcmsdemo; \ 
#	pip install -r requirements.txt; \
#	python manage.py migrate; \
#	python manage.py 0.0.0.0:8000;

#EXPOSE 8000