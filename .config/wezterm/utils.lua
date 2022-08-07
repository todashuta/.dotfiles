local M = {}
local wezterm = require 'wezterm'

function M.is_windows()
	return wezterm.target_triple == 'x86_64-pc-windows-msvc'
end

return M
