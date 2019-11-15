@ECHO OFF

SETLOCAL

REM https://github.com/bartmichu/windows-scripts/blob/master/mssql_backup.cmd

REM --------------------------------------------------
REM CONFIGURATION BLOCK STARTS HERE

REM SQL Server instance name (example: localhost\SQLEXPRESS)
SET "instance=localhost\SQLEXPRESS"

REM Cleanup time, in hours (example: one week = 168)
SET "cleanup=168"

REM Backups directory, without trailing backslash
SET "backupsDestination=C:\sql_backup"

REM Logs directory, without trailing backslash
SET "logsDestination=%backupsDestination%\logs"

REM CONFIGURATION BLOCK ENDS HERE
REM --------------------------------------------------

FOR /f "tokens=2 delims==" %%a IN ('wmic OS Get localdatetime /value') DO SET "dt=%%a"
SET "YY=%dt:~2,2%" & SET "YYYY=%dt:~0,4%" & SET "MM=%dt:~4,2%" & SET "DD=%dt:~6,2%"
SET "HH=%dt:~8,2%" & SET "Min=%dt:~10,2%" & SET "Sec=%dt:~12,2%"
SET "timestamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"

SET "logFile=%logsDestination%\%timestamp%.txt"

@ECHO ON

IF NOT EXIST "%backupsDestination%\" (mkdir "%backupsDestination%")
IF NOT EXIST "%logsDestination%\" (mkdir "%logsDestination%")

sqlcmd -E -S "%instance%" -d master -Q "EXECUTE dbo.DatabaseBackup @Databases = 'USER_DATABASES', @Directory = N'%backupsDestination%', @BackupType = 'FULL', @CleanupTime=%cleanup%" -b -o %logFile%

ENDLOCAL
