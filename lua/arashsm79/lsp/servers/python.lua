M = {}

function M.setup(on_attach, capabilities)
    local nvim_lsp = require("lspconfig")
    nvim_lsp.pylsp.setup({
        on_attach = function(client, bufnr) on_attach(client, bufnr, nil) end,
        capabilities = capabilities,
        settings = {
            pylsp = {
                plugins = {
                    pylint = {
                        enabled = true,
                        args = {
                            "--disable=invalid-name,missing-class-docstring,missing-function-docstring,missing-module-docstring,redefined-outer-name,too-few-public-methods",
                        },
                    },
                    rope_completion = {
                        enabled = true,
                    },
                },
            },
        },
    })
end

return M
