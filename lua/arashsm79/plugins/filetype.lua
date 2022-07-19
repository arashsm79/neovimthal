-- In init.lua or filetype.nvim's config file
require("filetype").setup({
	overrides = {
		extensions = {
			-- Set the filetype of *.pn files to potion
		    sdf = "xml",
		    nix = "nix",
		},
		literal = {
			-- Set the filetype of files named "MyBackupFile" to lua
			-- MyBackupFile = "lua",
		},
		complex = {
			-- Set the filetype of any full filename matching the regex to gitconfig
			-- [".*git/config"] = "gitconfig", -- Included in the plugin
		},

		-- The same as the ones above except the keys map to functions
		function_extensions = {
			["cpp"] = function()
				vim.opt.filetype = "cpp"
				vim.opt.cinoptions = vim.opt.cinoptions .. "L0"
				vim.opt.tabstop = 2 -- number of visual spaces per TAB
				vim.opt.softtabstop = 2 -- number of spaces in tab when editing
				vim.opt.shiftwidth = 2 -- number of spaces to use for autoindent
			end,
			["c"] = function()
				vim.opt.filetype = "c"
				vim.opt.cinoptions = vim.opt.cinoptions .. "L0"
				vim.opt.tabstop = 2 -- number of visual spaces per TAB
				vim.opt.softtabstop = 2 -- number of spaces in tab when editing
				vim.opt.shiftwidth = 2 -- number of spaces to use for autoindent
			end,
		},
		function_literal = {
			-- Brewfile = function()
			-- 	vim.cmd("syntax off")
			-- end,
		},
		function_complex = {
			-- ["*.math_notes/%w+"] = function()
			-- 	vim.cmd("iabbrev $ $$")
			-- end,
		},

		shebang = {
			-- Set the filetype of files with a dash shebang to sh
			-- dash = "sh",
		},
	},
})
