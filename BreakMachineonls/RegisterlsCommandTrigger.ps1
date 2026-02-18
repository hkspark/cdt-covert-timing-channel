Set-ItemPropty `
-Path "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" `
-Name "EnableScriptBlockLogging" `
-Value 1 -Force
Register-ScheduledTask -TaskName "lsCommandTrigger" `
    -Xml (Get-Content "C:\Temp\lsCommandTrigger.xml" | Out-String) `
    -User "SYSTEM"
