local function setup_highlight_under_cursor(bufnr)
    vim.cmd [[
        hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    ]]
    vim.api.nvim_create_augroup("lsp_document_highlight", {
        clear = false
    })
    vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

local function on_attach(client, bufnr, language_specific_keybindings)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Set  keybindings
    local keybindings = require("arashsm79.keybindings")
    keybindings.lsp.general()

    -- Set language specific bindings if given
    if language_specific_keybindings ~= nil then
        language_specific_keybindings()
    end

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider or client.server_capabilities.documentRangeFormattingProvider then
        keybindings.lsp.capabilities.formatting()
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        setup_highlight_under_cursor(bufnr)
    end

    -- Set winbar conditional on server_capabilities
    if client.server_capabilities.documentSymbolProvider then
        local navic = require "nvim-navic"
        navic.attach(client, bufnr)
        vim.o.winbar = "%{%v:lua.require('arashsm79.plugins.winbar').get_location()%}"
    end
end

-- Set capabilities
local function setup_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    return capabilities
end

local function setup_language_servers()
    local capabilities = setup_capabilities()
    local languages = {"c", "java", "haskell", "rust", "lua-lang", "python", "tex", "nix", "dart"}
    for _, language in ipairs(languages) do
        require("arashsm79.lsp.servers." .. language).setup(on_attach, capabilities)
    end
end

local function setup()
    setup_language_servers()
end

setup()
