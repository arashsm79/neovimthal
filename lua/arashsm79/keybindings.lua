local M = {}
local wk = require("which-key")

-- Misc and general mappings. Loaded on startup
M.misc = function()
    -- Remap space as leader key
    vim.keymap.set("", "<Space>", "<Nop>", { noremap = true })
    vim.g.mapleader = " "

    -- Add move line shortcuts
    vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true })
    vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true })
    vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true })
    vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true })
    vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true })
    vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true })

    -- Remove search highlight on escape
    vim.keymap.set("n", "<Esc>", ":noh <CR>", { noremap = true })

    -- Copying and pasting from system clipboard
    vim.keymap.set("v", "y", '"+y', { noremap = true })
    vim.keymap.set({ "n", "i", "v" }, "<C-c>", "<Esc>", { noremap = true })

    -- Better binding for exiting terminal mode
    vim.keymap.set("t", "<A-Space>", "<C-\\><C-n>", { noremap = true })

    -- Clear white space on empty lines and end of line
    vim.keymap.set(
        "n",
        "<F6>",
        [[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]],
        { noremap = true, silent = true }
    )
end

-- lsp
M.lsp = {
    general = function(bufnr)
        local b = require("telescope.builtin")
        wk.register({
            g = {
                name = "Go to",
                D = { vim.lsp.buf.declaration, "Go to declaraction" },
                d = { b.lsp_definitions, "Go to definition" },
                t = { b.lsp_type_definitions, "Go to type definition" },
                i = { b.lsp_implementations, "Go to implementation" },
                r = { b.lsp_references, "Go to references" },
            },
            K = { vim.lsp.buf.hover, "Hover help" },
            ["<c-k>"] = { vim.lsp.buf.signature_help, "Signature help" },
            ["[d"] = { vim.lsp.diagnostic.goto_prev, "Go to previous diagnostic" },
            ["]d"] = { vim.lsp.diagnostic.goto_next, "Go to next diagnostic" },
            ["<leader>"] = {
                w = {
                    name = "Workspace",
                    a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
                    r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
                    l = {
                        function()
                            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                        end,
                        "List workspace folders",
                    },
                },
                g = {
                    name = "Lsp",
                    r = { vim.lsp.buf.rename, "Rename" },
                    d = {
                        function()
                            b.diagnostics({ bufnr = nil }) -- nil for all buffers and 0 for current buffer
                        end,
                        "Show diagnostics",
                    },
                },
                s = { vim.lsp.buf.code_action, "Code Actions" },
                d = { vim.diagnostic.open_float, "Show line diagnostics" },
            },
        }, { buffer = bufnr })
        wk.register({
            g = {
                s = { "<ESC><cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Actions" },
            },
        }, { mode = "v", buffer = bufnr })
    end,
    capabilities = {
        formatting = function(bufnr)
            wk.register({
                g = {
                    name = "Lsp",
                    f = {
                        function()
                            vim.lsp.buf.format({ async = true })
                        end,
                        "Format File",
                    },
                },
            }, { prefix = "<leader>", buffer = bufnr })
            wk.register({
                g = {
                    name = "Lsp",
                    f = { "<ESC><cmd>lua vim.lsp.buf.range_formatting()<CR>", "Range Formatting" },
                },
            }, { prefix = "<leader>", mode = "v", buffer = bufnr })
        end,
    },
}

-- gitsigns
-- under namespace u
M.gitsigns = function(bufnr)
    local g = require("gitsigns")
    wk.register({
        u = {
            name = "Gitsigns",
            s = { g.stage_hunk, "Stage hunk" },
            r = { g.reset_hunk, "Reset hunk" },
        },
    }, { mode = "v", prefix = "<leader>", buffer = bufnr })

    wk.register({
        u = {
            name = "Gitsigns",
            S = { g.stage_buffer, "Stage buffer" },
            s = { g.stage_hunk, "Stage hunk" },
            u = { g.undo_stage_hunk, "Undo stage hunk" },
            R = { g.reset_buffer, "Reset buffer" },
            r = { g.reset_hunk, "Reset hunk" },
            p = { g.preview_hunk, "Preview hunk" },
            b = {
                function()
                    g.blame_line({ full = true })
                end,
                "Blame line",
            },
            t = { g.toggle_current_line_blame, "Toggle current line blame" },
            T = { g.toggle_deleted, "Toggle deleted" },
            d = { g.diffthis, "Diff this" },
            ["]"] = { g.next_hunk, "Next hunk", expr = true },
            ["["] = { g.previous_hunk, "Previus hunk", expr = true },
        },
    }, { prefix = "<leader>", buffer = bufnr })

    -- Text object
    vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr })
end

-- nvim-Tree
M.nvim_tree = function()
    wk.register({
        f = { ":NvimTreeToggle<CR>", "Toggle file explorer" },
    }, { prefix = "<leader>" })
end

-- nvim-cmp
M.nvim_cmp = function()
    local cmp = require("cmp")
    local types = require("cmp.types")
    local mapping = {
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-q>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    }
    return mapping
end

-- luasnip
M.luasnip = function()
    vim.keymap.set("i", "<Tab>", "v:lua.luasnip_tab_jump()", { expr = true })
    vim.keymap.set("s", "<Tab>", "v:lua.luasnip_tab_jump()", { expr = true })
    vim.keymap.set("i", "<S-Tab>", "v:lua.luasnip_s_tab_jump()", { expr = true })
    vim.keymap.set("s", "<S-Tab>", "v:lua.luasnip_s_tab_jump()", { expr = true })
    -- vim.keymap.set("i", "<C-s>", "<Plug>luasnip-next-choice", {})
    -- vim.keymap.set("s", "<C-s>", "<Plug>luasnip-next-choice", {})
end

-- toggle-term
M.toggle_term = function()
    return "<c-space>"
end

-- telescope
-- using namespace t
M.telescope = {
    telescope = function()
        local b = require("telescope.builtin")
        wk.register({
            t = {
                name = "Telescope",
                b = { b.buffers, "Buffers" },
                f = { b.current_buffer_fuzzy_find, "Fuzzy Find Buffer" },
                t = { b.resume, "Resume" },
                p = { b.pickers, "Cached Pickers" },
                s = { b.grep_string, "Grep String" },
                l = { b.live_grep, "Live Grep" },
                j = { b.jumplist, "Jump List" },
                g = {
                    name = "Git",
                    c = { b.git_commits, "Git Commits" },
                    b = { b.git_branches, "Git Branches" },
                    s = { b.git_status, "Git Status" },
                    h = { b.git_stash, "Git Stash" },
                },
                h = {
                    name = "History",
                    c = { b.command_history, "Command History" },
                    s = { b.search_history, "Search History" },
                },
                ["?"] = { b.oldfiles, "Recent Files" },
            },
            ["<space>"] = {
                function()
                    b.find_files({
                        hidden = true,
                        no_ignore = false,
                        no_ignore_parent = false,
                    })
                end,
                "Find Files",
            },
        }, { prefix = "<leader>" })
    end,
    todo_comments = function()
        wk.register({
            t = {
                name = "Telescope",
                d = { "<cmd>TodoTelescope<cr>", "Show TODOs" },
            },
        }, { prefix = "<leader>" })
    end,
    telescope_dap = function()
        local ted = require("telescope").extensions.dap
        wk.register({
            t = {
                name = "Telescope",
                a = {
                    name = "Debug Adapter",
                    c = { ted.commands, "Show DAP commands" },
                    o = { ted.configurations, "Choose DAP config" },
                    i = { ted.list_breakpoints, "List breakpoints" },
                    v = { ted.variables, "Show DAP variables" },
                    f = { ted.frames, "Show DAP frames" },
                },
            },
        }, { prefix = "<leader>" })
    end
}

-- nvim-bufferline
M.nvim_bufferline = function()
    wk.register({
        ["<leader>e"] = { "<cmd>BufferLineCyclePrev<CR>", "Previous buffer" },
        ["<leader>r"] = { "<cmd>BufferLineCycleNext<CR>", "Next buffer" },
        ["<leader>E"] = { "<cmd>BufferLineMovePrev<CR>", "Move buffer left" },
        ["<leader>R"] = { "<cmd>BufferLineMoveNext<CR>", "Move buffer right" },
        ["<leader>x"] = { "<cmd>bdelete!<CR>", "Close current buffer" },
        ["<leader><TAB>"] = { "<cmd>BufferLinePick<CR>", "Pick buffer" },
    })
end

-- nvim-dap
-- telescope-dap
-- using namespace d
M.nvim_dap = function()
    local d = require("dap")
    local duv = require("dap.ui.variables")
    local duw = require("dap.ui.widgets")
    wk.register({
        a = {
            name = "Debug Adapter",
            c = { d.continue, "Continue" },
            a = { d.step_over, "Step Over" },
            i = { d.step_into, "Step Into" },
            o = { d.step_out, "Step Out" },
            K = { duv.hover, "Hover" },
            k = { duv.visual_hover, "Visual Hover" },
            B = {
                name = "Breakpoints",
                c = {
                    function() d.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                    "Breakpoint Condition",
                },
                m = {
                    function() d.set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') }) end,
                    "Log Point Message",
                },
            },
            f = { function() duw.centered_float(duw.scopes) end, "Float" },
            w = { duw.hover, "Hover" },
            r = { d.repl.open, "Open REPL" },
            l = { d.repl.run_last, "Run Last Adapter" },
            b = { d.toggle_breakpoint, "Toggle Breakpoint" },
            s = { d.scopes, "Scopes" },
            t = { d.toggle, "Toggle" },
        },
    }, { prefix = "<leader>" })
end

-- hop
M.hop = function()
    local h = require("hop")
    wk.register({
        H = { h.hint_char1, "Char hint" },
        h = { h.hint_words, "Word hint" },
        l = { h.hint_lines, "Line hint" },
        L = { h.hint_char2, "Char Alt hint" },
    }, { prefix = "<leader>", noremap = false })
    wk.register({
        H = { h.hint_char1, "Char hint" },
        h = { h.hint_words, "Word hint" },
        l = { h.hint_lines, "Line hint" },
        L = { h.hint_char2, "Char Alt hint" },
    }, { mode = "v", prefix = "<leader>", noremap = false })
end

-- glow
M.glow = function()
    wk.register({
        name = "Glow Markdown",
        m = { "<cmd>Glow<cr>", "Glow Markdown" },
    }, { prefix = "<leader>" })
end

return M
