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
    if client.server_capabilities.document_formatting or client.server_capabilities.document_range_formatting then
        keybindings.lsp.capabilities.formatting()
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        setup_highlight_under_cursor(bufnr)
    end
end

-- Set capabilities
local function setup_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
    return capabilities
end

local function setup_language_servers()
    local capabilities = setup_capabilities()
    require("arashsm79.lsp.servers.c").setup(on_attach, capabilities)
    require("arashsm79.lsp.servers.java").setup(on_attach, capabilities)
    require("arashsm79.lsp.servers.haskell").setup(on_attach, capabilities)
    require("arashsm79.lsp.servers.rust").setup(on_attach, capabilities)
    require("arashsm79.lsp.servers.lua").setup(on_attach, capabilities)
    require("arashsm79.lsp.servers.python").setup(on_attach, capabilities)
    require("arashsm79.lsp.servers.tex").setup(on_attach, capabilities)
    require("arashsm79.lsp.servers.nix").setup(on_attach, capabilities)
    require("arashsm79.lsp.servers.dart").setup(on_attach, capabilities)
end

local function setup()
    setup_language_servers()
end

setup()
