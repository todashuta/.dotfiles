@echo off

set "ktx_cmd_opts=-v -noq -tc -kn"

set "gltfpack_exe_path=c:\path\to\gltfpack.exe"
set "ktx_cmd_arg1=%*"

if "%1" == "" (
	powershell -executionpolicy remotesigned -command "$opts = $($env:ktx_cmd_opts -split ' '); $items = get-childitem *.glb; foreach($f in $items) { $src = $f.basename + '.glb'; $dest = $f.basename + '_ktx.glb'; write-host; write-host $src '-->' $dest; & $env:gltfpack_exe_path @opts '-i' $src '-o' $dest; }"
) else (
	powershell -executionpolicy remotesigned -command "$opts = $($env:ktx_cmd_opts -split ' '); $f = get-item $env:ktx_cmd_arg1; $src = $f.basename + '.glb'; $dest = $f.basename + '_ktx.glb'; write-host; write-host $src '-->' $dest; & $env:gltfpack_exe_path @opts '-i' $src '-o' $dest;"
)

:EOF
