local wezterm = require 'wezterm'
local utils = require 'utils'

local launch_menu
if utils.is_windows() then
	launch_menu = {}
	table.insert(launch_menu, {
		label = 'cmd.exe',
		args = { 'cmd.exe' },
	})
	table.insert(launch_menu, {
		label = 'wsl.exe',
		args = { 'wsl.exe', '--cd', '~' },
	})
end

return {
	initial_cols = 150,
	initial_rows = 40,

	window_background_opacity = 0.9,

	font = wezterm.font_with_fallback {
		'M PLUS 1 Code',
		'VL Gothic',
	},
	font_size = 12.0,

	--color_scheme = 'Builtin Tango Dark',
	--color_scheme = 'tokyonight-storm',
	color_scheme = 'iceberg-dark',

	launch_menu = launch_menu,
}
