@echo off

pushd %~dp0

rem if "%1" == "" (
rem 	echo Usage:
rem 	echo   hello world
rem 	goto EOF
rem )

set "NOTEPAD_EXE=notepaad.exe"
where /q "%NOTEPAD_EXE%"
if errorlevel 1 (
	echo %NOTEPAD_EXE% not found!
	goto ERR
)

:EOF
popd
rem timeout /t 5
exit /b 0

:ERR
popd
pause
exit /b 1
