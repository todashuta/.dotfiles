@echo off

if "%CMD_INIT_SCRIPT_LOADED%" neq "" goto :EOF
set CMD_INIT_SCRIPT_LOADED=yes

doskey /macrofile=%~dp0.\init.macros
::set DISPLAY=localhost:0.0
::set HOME=%USERPROFILE%
::set EDITOR=gvim.exe

:EOF
exit /b 0
