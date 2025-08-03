@echo off

where /q mmv.exe
if errorlevel 1 (
	echo mmv not found!
	echo Please install mmv
	echo $ go install github.com/itchyny/mmv/cmd/mmv@latest
	goto ERR
)

set EDITOR=gvim
rem set "EDITOR=code -n --wait"

if "%1" == "" (
	mmv *
) else (
	mmv %*
)

:EOF
exit /b 0

:ERR
pause
exit /b 1
