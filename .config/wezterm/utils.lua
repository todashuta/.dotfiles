local M = {}
local wezterm = require 'wezterm'

function M.is_windows()
	return wezterm.target_triple == 'x86_64-pc-windows-msvc'
end
function M.is_mac()
	local t = wezterm.target_triple
	return t == 'x86_64-apple-darwin' or t == 'aarch64-apple-darwin'
end

return M
