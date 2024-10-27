local wezterm = require 'wezterm'
local act = wezterm.action
local utils = require 'utils'

local C = {}
if wezterm.config_builder then
	C = wezterm.config_builder()
end

C.use_ime = true

C.initial_cols = 150
C.initial_rows = 40

C.hide_tab_bar_if_only_one_tab = true

C.window_background_opacity = 0.9

if utils.is_mac() then
	C.window_decorations = "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW"
end

C.font = wezterm.font_with_fallback {
	'M PLUS 1 Code',
	'VL Gothic',

	{
		family = 'JetBrains Mono',
		harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
	},

	{ family = 'Shorai Sans StdN Var', weight = 1000 },

	'BIZ UDGothic', 'Meiryo', 'MS Gothic',
}
C.font_size = 11.0
C.line_height = 1.1
C.warn_about_missing_glyphs = false

--C.color_scheme = 'Builtin Tango Dark'
--C.color_scheme = 'tokyonight-storm'
C.color_scheme = 'iceberg-dark'

C.launch_menu = require 'launch_menu'

C.keys = {
	{
		key = 'Space',
		mods = 'CTRL|SHIFT',
		action = act.ShowLauncher,
	},
}

C.mouse_bindings = {
	-- Disable middle click paste
	{
		event = { Down = { streak = 1, button = 'Middle' } },
		mods = 'NONE',
		action = act.Nop,
	},

	-- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'NONE',
		action = act.CompleteSelection 'PrimarySelection',
	},

	-- and make CTRL-Click open hyperlinks
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CTRL',
		action = act.OpenLinkAtMouseCursor,
	},
}

return C
