$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument '-NoProfile -NonInteractive -WindowStyle Hidden -File "C:\PATH\updatefirewall.ps1"

$trigger = New-ScheduledTaskTrigger -At "OnEvent" -Subscription @"
<QueryList>
  <Query Id="0" Path="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall">
    <Select Path="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall">
    *[System[(EventID-2004)]]
    </Select>
  </Query>
</QueryList>
"@

Register-ScheduledTask -TaskName "FirewallOpenedTrigger2" -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest
