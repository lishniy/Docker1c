Start-Process "1CEnterprise_8_Server_(x86-64).msi" -ArgumentList '/qr TRANSFORMS=adminstallrelogon.mst;1049.mst DESIGNERALLCLIENTS=0 THICKCLIENT=0 THINCLIENTFILE=0 THINCLIENT=0 WEBSERVEREXT=0 SERVER=1 CONFREPOSSERVER=0 CONVERTER77=0 SERVERCLIENT=0 LANGUAGES=RU' -Wait
Remove-Item c:\sqlncli.msi -Force
sc.exe config "1C:Enterprise 8.3 Server Agent (x86-64)" depend= "/"