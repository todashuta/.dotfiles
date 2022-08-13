local wezterm = require 'wezterm'
local act = wezterm.action
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
	use_ime = true,

	initial_cols = 150,
	initial_rows = 40,

	hide_tab_bar_if_only_one_tab = true,

	window_background_opacity = 0.9,

	font = wezterm.font_with_fallback {
		'M PLUS 1 Code',
		'VL Gothic',

		{
			family = 'JetBrains Mono',
			harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
		},

		{ family = 'Shorai Sans StdN Var', weight = 1000 },

		'BIZ UDGothic', 'Meiryo', 'MS Gothic',
	},
	font_size = 11.0,
	line_height = 1.1,
	warn_about_missing_glyphs = false,

	--color_scheme = 'Builtin Tango Dark',
	--color_scheme = 'tokyonight-storm',
	color_scheme = 'iceberg-dark',

	launch_menu = launch_menu,

	keys = {
		{
			key = 'Space',
			mods = 'CTRL|SHIFT',
			action = act.ShowLauncher,
		},
	},

	mouse_bindings = {
		-- Disable middle click paste
		{
			event = { Down = { streak = 1, button = 'Middle' } },
			mods = 'NONE',
			action = act.Nop,
		},
	},
}
