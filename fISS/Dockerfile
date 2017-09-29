FROM microsoft/iis

RUN mkdir C:\site
RUN mkdir C:\site\upload
ADD space-science/ /site

RUN powershell -NoProfile -Command \
	Install-PackageProvider -Name nuget -Force

RUN powershell -NoProfile -Command \
	Install-Package python

RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
    New-IISSite -Name "Space-Science" -PhysicalPath C:\site\upload -BindingInformation "*:8000:"

EXPOSE 8000