@echo off

doskey /macrofile=%~dp0.\init.macros

if "%CMD_INIT_SCRIPT_LOADED%" neq "" goto :EOF
set CMD_INIT_SCRIPT_LOADED=1

::set DISPLAY=localhost:0.0
::set HOME=%USERPROFILE%
::set EDITOR=gvim.exe

:EOF
exit /b 0
