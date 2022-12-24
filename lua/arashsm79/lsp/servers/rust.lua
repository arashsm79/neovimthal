M = {}

function M.setup(on_attach, capabilities)
    require("rust-tools").setup({
        tools = { -- rust-tools options
            autoSetHints = true, -- Automatically set inlay hints (type hints)
            hover_with_actions = false, -- Whether to show hover actions inside the hover window. This overrides the default hover handler.
            executor = require("rust-tools/executors").toggleterm, -- how to execute terminal commands options right now: termopen / quickfix

            -- callback to execute once rust-analyzer is done initializing the workspace
            -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
            on_initialized = nil,
            runnables = {
                use_telescope = true, -- whether to use telescope for selection menu or not
                -- rest of the opts are forwarded to telescope
            },
            debuggables = {
                use_telescope = true, -- whether to use telescope for selection menu or not
                -- rest of the opts are forwarded to telescope
            },
            -- These apply to the default RustSetInlayHints command
            inlay_hints = {
                -- Event which triggers a refersh of the inlay hints.
                -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                -- not that this may cause  higher CPU usage.
                -- This option is only respected when only_current_line and
                -- autoSetHints both are true.
                only_current_line_autocmd = "CursorHold",
                only_current_line = false, -- Only show inlay hints for the current line
                show_parameter_hints = true, -- wheter to show parameter hints with the inlay hints or not
                show_variable_name = false, -- whether to show variable name before type hints with the inlay hints or not
                parameter_hints_prefix = "<- ", -- prefix for parameter hints
                other_hints_prefix = "=> ", -- prefix for all the other hints (type, chaining)
                max_len_align = false, -- whether to align to the length of the longest line in the file
                max_len_align_padding = 1, -- padding from the left if max_len_align is true
                right_align = false, -- whether to align to the extreme right or not
                right_align_padding = 7, -- padding from the right if right_align is true
                highlight = "Comment", -- The color of the hints
            },
        },
        server = {
            on_attach = function(client, bufnr) on_attach(client, bufnr,
                    require("arashsm79.keybindings").languages.rust.rust_tools)
            end,
            capabilities = capabilities,
            standalone = false, -- standalone file support setting it to false may improve startup time
            cmd_env = {
                -- CARGO_TARGET_DIR = "/tmp/rust-analyzer",
            },
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
        },
        dap = {
            adapter = {
                type = "executable",
                command = "lldb-vscode",
                name = "rt_lldb",
            },
            std_source_map = true,
            configuration = {
            }
        },
    })
end

return M
