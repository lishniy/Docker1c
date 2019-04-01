param(
[int]$regport=1541,
[int]$port=1540,
[string]$range="1560:1591",
[string]$debug="N",
[string]$servpath="C:\Program Files\1cv8\srvinfo",
[string]$log="N",
[string]$version="8.3.14.1630"
)
#range - для рабочего процесса;
#regport - для менеджера кластера;
#port - для агента сервера (не обязательно, если центральный сервер кластера один).

#$ipaddress=Get-NetIPAddress -SuffixOrigin "Manual" | Select-Object -ExpandProperty "IPAddress"
#write-host "Server 1C ip: " $ipaddress
Get-NetIPAddress | Format-Table

write-host "Installed version: " ($version)

$1cpath="C:\Program Files\1cv8\$version\bin"
$name="""$1cpath\ragent.exe"" -srvc -agent -regport $regport -port $port -range $range -d "
if($debug -eq "Y")
{
    write-host "Debug: enabled"
    $name=$name + " -debug"
}
$name=$name + """$servpath"""
write-host "Service ready to stop"
Stop-Service "1C:Enterprise 8.3 Server Agent (x86-64)"
write-host "Service was stoped"
if($log -eq "Y")
{
    write-host "Log path: c:\srvinfo\log\"
}

# if($repair -eq "Y")
# {
#     write-host "Repaire platform"
#     Copy-Item c:\backbas.dll $1cpath -force
# }

set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\1C:Enterprise 8.3 Server Agent (x86-64)' -name ImagePath -value $name ;
#Run depend services
#get-service '1C:Enterprise 8.3 Server Agent' | select-object -expand ServicesDependedOn | Where-Object status -eq "Stopped" | Start-Service
Start-Service '1C:Enterprise 8.3 Server Agent (x86-64)'
c:\Wait-Service.ps1 -ServiceName '1C:Enterprise 8.3 Server Agent (x86-64)' -AllowServiceRestart