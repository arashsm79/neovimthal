-- Vimtex
vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_syntax_enabled = 0
vim.g.vimtex_fold_manual = 1
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_latexmk = {
    build_dir = "output",
    callback = 1,
    continuous = 1,
    executable = "latexmk",
    hooks = {},
    options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
}

vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = [[--unique @pdf\#src:@tex:@line:@col]]
