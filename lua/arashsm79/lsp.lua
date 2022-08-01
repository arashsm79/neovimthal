local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local keybindings = require("arashsm79.keybindings")
    keybindings.lsp.general()
    keybindings.lsp.capabilities.formatting()

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.document_formatting or client.server_capabilities.document_range_formatting then
        keybindings.lsp.capabilities.formatting()
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
		hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
		hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
		hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
		augroup lsp_document_highlight
		autocmd!
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]],
            false
        )
    end
end

-- Set capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.codeAction.dynamicRegistration = false
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

--
-- Language Servers
--

-- Python
nvim_lsp.pylsp.setup({
    on_attach = on_attach,
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

-- Rust
require("rust-tools").setup({
    tools = { -- rust-tools options
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,

        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler
        hover_with_actions = false,

        -- how to execute terminal commands
        -- options right now: termopen / quickfix
        executor = require("rust-tools/executors").termopen,

        -- callback to execute once rust-analyzer is done initializing the workspace
        -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
        on_initialized = nil,

        runnables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true,

            -- rest of the opts are forwarded to telescope
        },

        debuggables = {
            -- whether to use telescope for selection menu or not
            use_telescope = true,

            -- rest of the opts are forwarded to telescope
        },

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {

            -- Only show inlay hints for the current line
            only_current_line = false,

            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,

            -- whether to show variable name before type hints with the inlay hints or not
            show_variable_name = false,

            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "Comment",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- For more settings, see:
    -- https://rust-analyzer.github.io/manual.html#configuration
    server = {
        -- standalone file support
        -- setting it to false may improve startup time
        on_attach = on_attach,
        capabilities = capabilities,
        standalone = false,
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importGranularity = "module",
                },
                checkOnSave = {
                    command = "clippy", -- or "check",
                },
                diagnostics = {
                    warningsAsHint = {
                        "clippy::pedantic",
                        "clippy::pattern_type_mismatch",
                    },
                    warningsAsInfo = {
                        "clippy::type_complexity",
                    },
                },
            },
        },
    }, -- rust-analyer options

    -- debugging stuff
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
        },
    },
})

-- Nix
nvim_lsp.rnix.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Haskell
nvim_lsp.hls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Java
nvim_lsp.java_language_server.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "java-language-server" },
})

-- LaTeX
nvim_lsp.texlab.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        texlab = {
            rootDirectory = nil,
            build = {
                executable = "latexmk",
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                onSave = true,
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

-- C/C++
nvim_lsp.clangd.setup({
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- Lua
nvim_lsp.sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "lua-language-server" },
    -- For more settings, see:
    -- https://github.com/sumneko/lua-language-server/wiki/Setting#json-schema
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

-- Dart
nvim_lsp.dartls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
