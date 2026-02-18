$action = New-ScheduledTaskAction -Execute "powershell.exe" -ArgumentList "-NoProfile -NonInteractive -WindowStyle Hidden -Command `"while (True){Start-Process notepad.exe`""

$trigger = New-ScheduledTaskTrigger -OnEvent -Subscription @"
<QueryList>
  <Query Id="0" Path="Microsoft-Windows-PowerShell/Operational">
    <Select Path="Microsoft-Windows-PowerShell/Operational">
    *[System[(EventID=4104)] and EventData[Data and conatins(Data, 'ls')]]
    </Select>
  </Query>
</QueryList>
"@

Register-ScheduledTask -TaskName "lsCommandTrigger" -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest
