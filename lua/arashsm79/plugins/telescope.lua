-- Telescope
-- Under namespace 't'

-- If you'd prefer Telescope not to enter a normal-like mode when
-- hitting escape (and instead exiting), you can map <Esc> to do so via:
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
})

-- Set related keybindings
require("arashsm79.keybindings").telescope.telescope()
