Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled false
Set-WinSystemLocale ru-RU
Set-Culture ru-RU
tzutil /s "Russian Standard Time"
Set-WinHomeLocation -GeoId 203
