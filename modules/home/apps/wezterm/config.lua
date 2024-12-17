-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.enable_scroll_bar = true
config.enable_wayland = false
config.default_cursor_style = "BlinkingBar"

-- and finally, return the configuration to wezterm
return config