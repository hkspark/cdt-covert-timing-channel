Register-ScheduledTask -TaskName "FirewallOpenedTrigger2" `
    -Xml (Get-Content "C:\PATH\FirewallOpenedTrigger2.xml" | Out-String) `
    -User "SYSTEM"
