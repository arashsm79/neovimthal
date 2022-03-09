# Neovimthal
> [Neovim](https://github.com/neovim/neovim) configuration written in Lua targeting Neovim nightly.


## 📔 Requirements

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
- [Neovim Nightly](https://github.com/neovim/neovim)

## ⚙️ Installation

```
git clone https://github.com/arashsm79/neovimthal ~/.config/nvim
nvim +PackerSync
```

## 📐 Architecture
```
nvim
├── init.lua
├── lua
│   └── arashsm79
│       ├── keybindings.lua
│       ├── lsp.lua
│       ├── options.lua
│       ├── packer.lua
│       ├── plugins
        └── utils.lua
```
- keybindings: Every single keybinding used throughout the config, is declared here. Most of the keybindings are set using which-key.
- lsp: Configurations for language servers are declared here. The language servers must be available in the PATH seen by Neovim (simply wrap Neovim with the needed LSPs).
- options: Sets the general options for Neovim.
- packer: Plugin manager.
- plugins: Plugin specific configurations reside in this folder. Check out packer.lua for a list of plugins.

