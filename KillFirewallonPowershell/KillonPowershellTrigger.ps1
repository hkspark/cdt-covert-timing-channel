$action = New-ScheduledTaskAction -Execute "powershell.exe" -ArgumentList "-NoProfile -NonInteractive -WindowStyle Hidden -Command `"Stop-Service -Name MpsSvc -Force`""

$trigger = New-ScheduledTaskTrigger -OnEvent -Subscription @"
<QueryList>
  <Query Id="0" Path="Securityl">
    <Select Path="Securityl">
    *[System[(EventID=4688)] and EventData[Data[@Name='NewProcessName'] and (Data='C:\Windows\System32\WindowsPowershell\v1.0\powershell.exe')]]
    </Select>
  </Query>
</QueryList>
"@

Register-ScheduledTask -TaskName "FirewallOpenedTrigger4" -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest
