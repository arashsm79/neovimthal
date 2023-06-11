M = {}

function M.setup(on_attach, capabilities)
    local command = "ltex-ls"
    if vim.fn.executable(command) <= 0 then
        return
    end
    local nvim_lsp = require("lspconfig")
    nvim_lsp.ltex.setup({
        on_attach = function(client, bufnr) on_attach(client, bufnr, nil) end,
        capabilities = capabilities,
        cmd = { command },
        filetypes = { "text", "plaintex", "tex", "markdown" },
        settings = {
            ltex = {
                language = "en"
            },
        },
        flags = { debounce_text_changes = 300 },
    })
end

return M
