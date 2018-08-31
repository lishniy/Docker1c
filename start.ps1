param(
[int]$regport=1541,
[int]$port=1540,
[string]$range="1560:1591",
[string]$debug="N",
[string]$servpath="C:\Program Files (x86)\1cv8\srvinfo"
)
#range - для рабочего процесса;
#regport - для менеджера кластера;
#port - для агента сервера (не обязательно, если центральный сервер кластера один).
$version=Get-WmiObject -Class Win32_Product | where {$_.name -like '*1C*'} | select -ExpandProperty "version"
$1cpath="C:\Program Files (x86)\1cv8\$version\bin"
Set-MpPreference -DisableRealtimeMonitoring $true
$name="""$1cpath\ragent.exe"" -srvc -agent -regport $regport -port $port -range $range -d ""$servpath"""
if($debug -eq "Y")
{
    $name=$name + " -debug"
}
write-host ($version)
Write-Verbose "Stoping 1C service"
stop-service '1C:Enterprise 8.3 Server Agent'
Write-Verbose "Setting up 1C service"
set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\1C:Enterprise 8.3 Server Agent' -name ImagePath -value $name ;
Write-Verbose "Starting 1C service"
start-service '1C:Enterprise 8.3 Server Agent'
Write-Verbose "1C service started"

c:\Wait-Service.ps1 -ServiceName '1C:Enterprise 8.3 Server Agent' -AllowServiceRestart
