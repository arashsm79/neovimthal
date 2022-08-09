M = {}

function M.setup(on_attach, capabilities)
    local nvim_lsp = require("lspconfig")
    nvim_lsp.sumneko_lua.setup({
        on_attach = function(client, bufnr) on_attach(client, bufnr, nil) end,
        capabilities = capabilities,
        cmd = { "lua-language-server" },
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.list_extend(vim.split(package.path, ";"), { "lua/?.lua", "lua/?/init.lua" }),
                },
                diagnostics = {
                    globals = { "vim", "use" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
end

return M
