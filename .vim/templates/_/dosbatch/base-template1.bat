@echo off

pushd %~dp0

rem if "%1" == "" (
rem 	echo Usage:
rem 	echo   hello world
rem 	goto DONE
rem )

set "NOTEPAD_EXE=notepaad.exe"
where /q "%NOTEPAD_EXE%"
if errorlevel 1 (
	echo %NOTEPAD_EXE% not found!
	goto ERR
)

:DONE
popd
rem if /i %0 equ "%~f0" timeout /t 5
exit /b 0

:ERR
popd
if /i %0 equ "%~f0" pause
exit /b 1
