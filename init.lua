-- Neovim configuration of Arash Sal Moslehian
-- Since 2020
--
-- Install Packer if it's not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.api.nvim_command("packadd packer.nvim")
end

-- Load in injections if they're set
if vim.env.NVIM_LUA_INJECTION ~= nil then
    vim.g.injection = dofile(vim.env.NVIM_LUA_INJECTION)
end

-- Basic general options
require("arashsm79.options")

-- If loading inside VSCode, don't load any other configurations
if vim.fn.exists("g:vscode") ~= 0 then
    return 0
end

-- Keybindings
require("arashsm79.keybindings").misc()

-- If inside a browser, selectively load the following plugins and exit
if vim.fn.exists("g:started_by_firenvim") ~= 0 then
    require("arashsm79.plugins.firenvim")
    require("arashsm79.plugins.nvim-cmp")
    require("arashsm79.plugins.nvim-hop")
    require("arashsm79.plugins.treesitter")
    require("arashsm79.plugins.which-key")
    require("arashsm79.plugins.telescope")
    return 0
end

-- Plugin manager configuration
require("arashsm79.packer")

-- LSP configurations
require("arashsm79.lsp")

-- Reload config
function _G.reload_nvim_conf()
    for name, _ in pairs(package.loaded) do
        if name:match("^arashsm79") then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    print("Configuration reloaded.")
end
vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua reload_nvim_conf()<CR>", {})
