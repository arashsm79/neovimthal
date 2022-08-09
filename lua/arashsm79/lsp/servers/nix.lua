M = {}

function M.setup(on_attach, capabilities)
    local nvim_lsp = require("lspconfig")
    nvim_lsp.rnix.setup({
        on_attach = function(client, bufnr) on_attach(client, bufnr, nil) end,
        capabilities = capabilities,
    })
end

return M
