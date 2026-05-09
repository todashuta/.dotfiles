@echo off

pushd %~dp0

set build_dir=.\build

if "%VCVARS_LOADED%" neq "" goto :CMAKE_CONFIGURE
call "C:\Program Files (x86)\Microsoft Visual Studio\2026\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
if errorlevel 1 (
	goto ERR
)
set VCVARS_LOADED=1

:CMAKE_CONFIGURE
cmake ^
	-B %build_dir% ^
	-G Ninja ^
	-DCMAKE_TOOLCHAIN_FILE="C:\Devel\vcpkg\scripts\buildsystems\vcpkg.cmake" ^
	-DCMAKE_BUILD_TYPE=Release
if errorlevel 1 (
	goto ERR
)

:CMAKE_BUILD
cmake --build %build_dir% -j
if errorlevel 1 (
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
