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

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return "Hello, world"
end)

-- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 14
config.color_scheme = "Modus Vivendi (Gogh)"

config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false

config.font = wezterm.font("Hasklug Nerd Font")

config.window_padding = {
	left = "2cell",
	right = "2cell",
	top = "1cell",
	bottom = "1cell",
}

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- Disable selected mouse bindings

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.Nop, -- Disable default copy to clipboard
	},
}

-- If needed to disable everything
-- config.disable_default_mouse_bindings = true

config.keys = {
	-- Turn off the default CTRL-= Zoom In action
	-- CRTL-+ does the same action by default
	{
		key = "=",
		mods = "CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- Disable bell sound
config.audible_bell = "Disabled"

-- Finally, return the configuration to wezterm:
return config
