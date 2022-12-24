M = {}

function M.setup(on_attach, capabilities)
    local nvim_lsp = require("lspconfig")
    nvim_lsp.texlab.setup({
        on_attach = function(client, bufnr) on_attach(client, bufnr, nil) end,
        capabilities = capabilities,
        settings = {
            texlab = {
                rootDirectory = nil,
                build = {
                    executable = "latexmk",
                    args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                    onSave = false,
                    forwardSearchAfter = false,
                },
                auxDirectory = ".",
                forwardSearch = {
                    executable = nil,
                    args = {},
                },
                chktex = {
                    onOpenAndSave = false,
                    onEdit = false,
                },
                diagnosticsDelay = 300,
                latexFormatter = "latexindent",
                latexindent = {
                    ["local"] = nil, -- local is a reserved keyword
                    modifyLineBreaks = false,
                },
                bibtexFormatter = "texlab",
                formatterLineLength = 80,
            },
        },
    })
end

return M
