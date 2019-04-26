@ECHO OFF

ECHO Disabling audit events for Filtering Platform Packet Drop

C:\Windows\System32\auditpol.exe /set /SubCategory:"Filtering Platform Packet Drop" /success:disable /failure:disable

PAUSE
