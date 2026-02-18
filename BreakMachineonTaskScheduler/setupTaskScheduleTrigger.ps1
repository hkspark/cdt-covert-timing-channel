auditpol /set /subcategory:"Process Creation" /success:enable
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit" `
/v ProcessCreationIncludeCmdLine_Enabled /t REG_DWORD /d 1 /f
