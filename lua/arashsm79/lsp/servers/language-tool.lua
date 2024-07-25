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
                language = "en-US",
                additionalRules = {
                    enablePickyRules = true,
                    motherTongue = "en-US",
                },
                dictionary = {
                    ["en_US"] = { ":/home/arashsm79/.config/nvim/dictionary/en-dictionary.txt" },
                },
                disabledRules = {
                    ["en-US"] = {"WHITESPACE_RULE"}
                },
            },
        },
        flags = { debounce_text_changes = 300 },
    })
end

return M
