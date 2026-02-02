-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 10
config.color_scheme = 'OneDark (base16)'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.enable_tab_bar = false  -- Hide tab bar

--config.window_background_opacity = 0.98
--config.background = {
--  {
--	source = {Color="black"},
--	width = "100%",
--	height = "100%",
--	opacity = 0.8,
--  },
--  {
--    source = { File = "/home/khacson/background-image.png" },
--    opacity = 0.1,
--  }
--}

config.keys = {
  {key = "Z", mods = "CTRL", action = wezterm.action.EmitEvent("toggle-tabbar")},
  {key = "F11", action = wezterm.action.ToggleFullScreen},
}

wezterm.on(
    "toggle-tabbar",
    function(window, _)
        local overrides = window:get_config_overrides() or {}
        if overrides.enable_tab_bar == false then
            wezterm.log_info("tab bar shown")
            overrides.enable_tab_bar = true
        else
            wezterm.log_info("tab bar hidden")
            overrides.enable_tab_bar = false
        end
        window:set_config_overrides(overrides)
    end
)

wezterm.on("format-window-title", function(tab, pane)
  local process = pane.foreground_process_name

  if process:find("nvim") then
    return "" -- delete title nvim
  end

  return tab.active_pane.title
end)

-- Finally, return the configuration to wezterm:
return config

