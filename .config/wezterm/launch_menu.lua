local utils = require 'utils'
local launch_menu = {}

if utils.is_windows() then
	table.insert(launch_menu, {
		label = 'pwsh.exe -ExecutionPolicy RemoteSigned',
		args = { 'pwsh.exe', '-ExecutionPolicy', 'RemoteSigned' },
	})
	table.insert(launch_menu, {
		label = 'powershell.exe -ExecutionPolicy RemoteSigned',
		args = { 'powershell.exe', '-ExecutionPolicy', 'RemoteSigned' },
	})
	table.insert(launch_menu, {
		label = 'cmd.exe',
		args = { 'cmd.exe' },
	})
	table.insert(launch_menu, {
		label = 'wsl.exe',
		args = { 'wsl.exe', '--cd', '~' },
	})
end

return launch_menu
