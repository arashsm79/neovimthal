M = {}

function M.setup(on_attach, capabilities)
    local nvim_lsp = require("lspconfig")
    nvim_lsp.java_language_server.setup({
        on_attach = function(client, bufnr) on_attach(client, bufnr, nil) end,
        capabilities = capabilities,
        cmd = { "java-language-server" },
    })
end

return M
