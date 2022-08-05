@ECHO OFF

pushd %~dp0

if "%1" == "" goto help
if not "%2" == "" goto toomanyargs

if "%1" == "all" (
	echo.setup all: Not Implemented Yet
	goto end
)

if "%1" == "vim" (
	echo.setup vim: Not Implemented Yet
	goto end
)

:unknown
echo.Unknown option: %*
goto end

:toomanyargs
echo.Too many arguments: %*
goto end

:help
echo.Help:
echo.  setup.bat all
echo.  setup.bat vim

:end
popd
