Register-ScheduledTask -TaskName "FirewallOpenedTrigger2" `
    -Xml (Get-Content "C:\PATH\UpdateFirewallRulesTrigger.xml" | Out-String) `
    -User "SYSTEM"
