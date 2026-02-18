$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument '-NoProfile -NonInteractive -WindowStyle Hidden -File "C:\PATH\breakmachine.ps1"

$trigger = New-ScheduledTaskTrigger -At "OnEvent" -Subscription @"
<QueryList>
  <Query Id="0" Path="Microsoft-Windows-PowerShell/Operational">
    <Select Path="Microsoft-Windows-PowerShell/Operational">
    *[System[(EventID-4104)] and EventData[Data and conatins(Data, 'ls')]]
    </Select>
  </Query>
</QueryList>
"@

Register-ScheduledTask -TaskName "lsCommandTrigger" -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest
