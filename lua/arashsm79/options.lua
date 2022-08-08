local opt = vim.opt

-- Set the theme
vim.cmd([[colorscheme codedark]])
vim.g.transparent_enabled = true

-- Incremental live completion
opt.inccommand = "nosplit"

-- Always use the system clipboard
-- opt.clipboard = "unnamedplus"

-- Better window title (turned off for now because of bug in ncurses)
opt.title = false

-- Remove default status line
-- opt.cmdheight = 0

-- Don't show mode in default status line
opt.showmode = false

-- Enable mouse support in 'a'll modes
opt.mouse = "a"

-- Always show the sign column
opt.signcolumn = "yes"

-- Splitting
opt.splitbelow = true
opt.splitright = true

-- Number of ms to wait for key mapping press
opt.timeoutlen = 500

-- Set highlight on search
opt.hlsearch = true
opt.incsearch = true

-- Make line numbers default
opt.number = true
opt.relativenumber = true

-- Do not save when switching buffers
opt.hidden = true

-- Enable mouse mode
opt.mouse = "a"

-- Enable break indent
opt.breakindent = true

-- Set show command
opt.showcmd = true

-- Save undo history
opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Set colorscheme (order is important here)
opt.termguicolors = true

-- Change preview window location
opt.splitbelow = true

-- Set completeopt to have a better completion experience
opt.completeopt = "menu,menuone,noselect"

-- Tab stuff
opt.tabstop = 4 -- number of visual spaces per TAB
opt.softtabstop = 4 -- number of spaces in tab when editing
opt.shiftwidth = 4 -- number of spaces to use for autoindent
opt.expandtab = true -- tabs are space
opt.smartindent = true

-- auto commands
--
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
    desc = "Highlight yank",
})
