@echo off

where /q ghq.exe
if errorlevel 1 (
	echo ghq not found!
	echo Please install ghq
	goto ERR
)

where /q peco.exe
if errorlevel 1 (
	echo peco not found!
	echo Please install peco
	exit /b 1
)

for /f %%i in ('ghq list -p ^| peco') do (
  rem cd /d %%i
  pushd %%i
  break
)

:EOF
exit /b 0

:ERR
exit /b 1
