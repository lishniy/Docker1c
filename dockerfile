FROM microsoft/windowsservercore
ENV regport=1541 \  
    port=1540 \
    range="1560:1591" \
    debug="N" \
    log="N"
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR /
COPY logcfg.xml start.ps1 prepare.ps1 Wait-Service.ps1 1CEnterprise_8_Server_(x86-64).msi sqlncli.msi ./
RUN powershell.exe -Command Remove-Item prepare.ps1 -Force
CMD .\start.ps1 -regport $env:regport -port $env:port -range $env:range -debug $env:debug -servpath "C:\srvinfo" -log $env:log -Verbose