-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- smartsplits.nvim
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Kanagawa (Gogh)'
-- config.font = wezterm.font 'JetBrains Mono'
config.font = wezterm.font 'Fira Code'
config.default_cwd = os.getenv("HOME") .. "/Source";

-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'h', 'j', 'k', 'l' },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'META', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'CTRL', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
})

config.keys = {
  {
    key = '!',
    mods = 'META',
    action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_tab()
    end),
  },
}
config.hyperlink_rules = {
	-- linkify email addresses
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{ regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]], format = "mailto:$0" },
	-- file:// URI
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{ regex = [[\bfile://\S*\b]], format = "$0" },

	-- Make username/project paths clickable. This implies paths like the following are for GitHub.
	-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
	-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
	-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
	{ regex = [["([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)"]], format = "https://www.github.com/$1/$3" },

	-- { regex = [[localhost:(\d+)]], format = "http://localhost:$1" },
}

-- and finally, return the configuration to wezterm
return config
