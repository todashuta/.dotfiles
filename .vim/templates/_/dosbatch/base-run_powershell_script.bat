@echo off
pushd %~dp0
powershell.exe -ExecutionPolicy RemoteSigned -File .\main.ps1
pause
