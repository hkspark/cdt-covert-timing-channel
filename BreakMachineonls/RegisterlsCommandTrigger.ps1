Register-ScheduledTask -TaskName "lsCommandTrigger" `
    -Xml (Get-Content "C:\Temp\lsCommandTrigger.xml" | Out-String) `
    -User "SYSTEM"
