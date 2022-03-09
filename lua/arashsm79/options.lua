local opt = vim.opt
local g = vim.g

-- Set the theme
vim.cmd([[colorscheme codedark]])

-- Incremental live completion
opt.inccommand = "nosplit"

-- Always use the system clipboard
-- opt.clipboard = "unnamedplus"

-- Better window title
opt.title = true

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
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- auto commands
--
-- Highlight on yank
vim.cmd([[ au TextYankPost * silent! lua opt.on_yank() ]])

-- Don't show any numbers inside terminals
vim.cmd([[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]])
