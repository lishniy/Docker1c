FROM microsoft/windowsservercore
ENV regport=1541 \  
    port=1540 \
    range="1560:1591" \
    debug="N"
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR /
COPY prepare.ps1 /prepare.ps1 && start.ps1 /start.ps1 && Wait-Service.ps1 /Wait-Service.ps1 && 1cEntRepack_x86.exe c:/temp/
RUN .\prepare.ps1
RUN powershell.exe -Command Start-Process c:\temp\1cEntRepack_x86.exe -ArgumentList '-aiG' -Wait && powershell.exe -Command Remove-Item c:\temp\1cEntRepack_x86.exe -Force
CMD .\start.ps1 -regport $env:regport -port $env:port -range $env:range -debug $env:debug -servpath "C:\srvinfo" -Verbose
