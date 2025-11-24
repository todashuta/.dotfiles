@ECHO OFF

pushd %~dp0
powershell.exe -ExecutionPolicy RemoteSigned -File .\setup.ps1 %*

:end
popd
