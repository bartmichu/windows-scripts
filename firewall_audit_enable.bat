@ECHO OFF

ECHO Enabling audit events for Filtering Platform Packet Drop

C:\Windows\System32\auditpol.exe /set /SubCategory:"Filtering Platform Packet Drop" /success:enable /failure:enable

PAUSE
