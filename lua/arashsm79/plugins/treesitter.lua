-- TreeSitter
require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ignore_install = { "fusion" },
	highlight = {
		disable = { "latex", "fusion" },
		enable = true, -- false will disable the whole extension
	},
	indent = {
		enable = true,
	},
})
vim.wo.foldmethod = "expr"
vim.wo.foldlevel = 0
vim.wo.foldminlines = 1
vim.wo.foldnestmax = 1
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
