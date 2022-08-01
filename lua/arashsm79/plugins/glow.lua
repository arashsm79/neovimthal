require("glow").setup({
    glow_path = "glow", -- filled automatically with your glow bin in $PATH,
    glow_install_path = "", -- default path for installing glow binary
    border = "shadow", -- floating window border config
    style = "dark", -- filled automatically with your current editor background, you can override using glow json style
    pager = false,
    width = 100,
})
require("arashsm79.keybindings").glow()
