Register-ScheduledTask -TaskName "FirewallOpenedTrigger" `
    -Xml (Get-Content "C:\PATH\TaskSchedulerTrigger.xml" | Out-String) `
    -User "SYSTEM"
