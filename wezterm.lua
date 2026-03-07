-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

local mux = wezterm.mux
local act = wezterm.action

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "wsl", "~" }
end

-- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 14
config.color_scheme = "Modus Vivendi (Gogh)"

config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false

config.font = wezterm.font("Hasklug Nerd Font")

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.Nop,
	},
}

-- Finally, return the configuration to wezterm:
return config
