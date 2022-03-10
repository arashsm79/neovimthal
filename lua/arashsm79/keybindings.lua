local M = {}
local wk = require("which-key")

-- Misc and general mappings. Loaded on startup
M.misc = function()
	-- Remap space as leader key
	vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true })
	vim.g.mapleader = " "

	-- Add move line shortcuts
	vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true })
	vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true })
	vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true })
	vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true })
	vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true })
	vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true })

	-- Remove search highlight on escape
	vim.api.nvim_set_keymap("n", "<Esc>", ":noh <CR>", { noremap = true })

	-- Copying and pasting from system clipboard
	vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true })
	vim.api.nvim_set_keymap("n", "<C-c>", "<Esc>", { noremap = true })
	vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true })
	vim.api.nvim_set_keymap("i", "<C-v>", "<C-r>+", { noremap = true })

	-- Better binding for exiting terminal mode
	vim.api.nvim_set_keymap("t", "<C-Space>", "<C-\\><C-n>", { noremap = true })

	-- Clear white space on empty lines and end of line
	vim.api.nvim_set_keymap(
		"n",
		"<F6>",
		[[:let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]],
		{ noremap = true, silent = true }
	)
end

-- Language server protocol
M.lsp = {
	general = function(bufnr)
		wk.register({
			g = {
				name = "Go to",
				D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaraction" },
				d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
				t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Show type definition" },
				i = { "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
				r = { "<Cmd>lua vim.lsp.buf.references()<CR>", "Show references" },
				c = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Code Actions" },
			},
			K = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover help" },
			["<c-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
			["<leader>"] = {
				w = {
					name = "Workspace",
					a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add workspace folder" },
					r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove workspace folder" },
					l = {
						"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
						"List workspace folders",
					},
				},
				g = {
					name = "Lsp",
					r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
					d = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Set diagnostic local list" },
				},
				e = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Show line diagnostics" },
			},
			["[d"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Go to next diagnostic" },
			["]d"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Go to previous diagnostic" },
		}, { buffer = bufnr })
	end,
	capabilities = {
		formatting = function(bufnr)
			wk.register({
				g = {
					name = "Lsp",
					f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format file" },
				},
			}, { prefix = "<leader>", buffer = bufnr })
		end,
	},
}

-- gitsigns
-- under namespace u
M.gitsigns = function(bufnr)
	wk.register({
		u = {
			name = "Gitsigns",
			s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
			r = { ":Gitsigns stage_hunk<CR>", "Reset hunk" },
		},
	}, { mode = "nv", prefix = "<leader>", buffer = bufnr })

	wk.register({
		u = {
			name = "Gitsigns",
			S = { "<cmd>lua package.loaded.gitsigns.stage_buffer()<cr>", "Stage buffer" },
			u = { "<cmd>lua package.loaded.gitsigns.undo_stage_hunk()<cr>", "Undo stage hunk" },
			R = { "<cmd>lua package.loaded.gitsigns.reset_buffer()<cr>", "Reset buffer" },
			p = { "<cmd>lua package.loaded.gitsigns.preview_hunk()<cr>", "Preview hunk" },
			b = { "<cmd>lua package.loaded.gitsigns.blame_line{full=true}<cr>", "Blame line" },
			t = { "<cmd>lua package.loaded.gitsigns.toggle_current_line_blame()<cr>", "Toggle current line blame" },
			T = { "<cmd>lua package.loaded.gitsigns.toggle_deleted()<cr>", "Toggle deleted" },
			d = { "<cmd>lua package.loaded.gitsigns.diffthis()<cr>", "Diff this" },
			D = { "<cmd>lua package.loaded.gitsigns.gs.diffthis('~')<cr>", "Diff this ~" },
		},
		["]c"] = { "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", "Next hunk", expr = true },
		["[c"] = { "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", "Previus hunk", expr = true },
	}, { prefix = "<leader>", buffer = bufnr})

	wk.register({
		["]c"] = { "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", "Next hunk", expr = true },
		["[c"] = { "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", "Previus hunk", expr = true },
	}, {buffer = bufnr})

	-- Text object
	vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {buffer = bufnr})
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
	local mapping = {
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-q>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
	}
	return mapping
end

-- luasnip (used for LSP snippets)
M.luasnip = function()
	vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.luasnip_tab_jump()", { expr = true })
	vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.luasnip_tab_jump()", { expr = true })
	vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.luasnip_s_tab_jump()", { expr = true })
	vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.luasnip_s_tab_jump()", { expr = true })
	-- vim.api.nvim_set_keymap("i", "<C-s>", "<Plug>luasnip-next-choice", {})
	-- vim.api.nvim_set_keymap("s", "<C-s>", "<Plug>luasnip-next-choice", {})
end

-- Ultisnips (only used for latex files)
M.ultisnips = function()
	vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
	vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
	vim.g.UltiSnipsExpandTrigger = "<C-q>"
end

-- Toggle terminal
M.toggle_term = function()
	return "<c-space>"
end

-- telescope
-- using namespace t
M.telescope = function()
	wk.register({
		t = {
			name = "Telescope",
			b = { "<cmd>Telescope buffers<cr>", "Show buffers" },
			f = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find buffer" },
			t = { "<cmd>Telescope tags<cr>", "Show tags" },
			["?"] = { "<cmd>Telescope oldfiles<cr>", "Show recent files" },
			s = { "<cmd>Telescope grep_string<cr>", "grep string" },
			l = { "<cmd>Telescope live_grep<cr>", "Live grep" },
		},
		["<space>"] = { [[<cmd>Telescope find_files<cr>]], "Find Files" },
	}, { prefix = "<leader>" })
end

-- nvim-bufferline
M.nvim_bufferline = function()
	wk.register({
		["[b"] = { "<cmd>BufferLineCyclePrev<CR>", "Previous buffer" },
		["]b"] = { "<cmd>BufferLineCycleNext<CR>", "Next buffer" },
		["[h"] = { "<cmd>BufferLineMovePrev<CR>", "Move buffer left" },
		["]h"] = { "<cmd>BufferLineMoveNext<CR>", "Move buffer right" },
		["<leader><TAB>"] = { "<cmd>BufferLinePick<CR>", "Pick buffer" },
	})
end

-- nvim dap
-- telescope-dap
-- using namespace d
M.nvim_dap = function()
	wk.register({
		d = {
			name = "Debug Adapter",
			-- nvim dap
			b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
			B = {
				"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				"Set breakpoint with condition",
			},
			l = {
				"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
				"Set breakpoint with log",
			},
			["?"] = { "<cmd>lua require'dap'.repl.open()<CR><cr>", "Open REPL" },
			r = { "<cmd>lua require'dap'.run_last()<CR>", "Run last" },
			-- telescope-dap
			c = { "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>", "Show DAP commands" },
			o = { "<cmd>lua require'telescope'.extensions.dap.configurations{}<CR>", "Choose DAP config" },
			i = { "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>", "List breakpoints" },
			v = { "<cmd>lua require'telescope'.extensions.dap.variables{}<CR>", "Show DAP variables" },
			f = { "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>", "Show DAP frames" },
		},
	}, { prefix = "<leader>" })
	wk.register({
		["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Debug continue" },
		["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Debug step over" },
		["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Debug step into" },
		["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "Debug step out" },
	})
end

-- hop.nvim
M.hop = function()
	wk.register({
		H = { "<cmd>lua require'hop'.hint_char1()<CR>", "Char hint" },
		h = { "<cmd>lua require'hop'.hint_words()<CR>", "Word hint" },
		l = { "<cmd>lua require'hop'.hint_lines()<CR>", "Line hint" },
		L = { "<cmd>lua require'hop'.hint_char2()<CR>", "Char Alt hint" },
	}, { prefix = "<leader>", noremap = false })
	wk.register({
		H = { "<cmd>lua require'hop'.hint_char1()<CR>", "Char hint" },
		h = { "<cmd>lua require'hop'.hint_words()<CR>", "Word hint" },
		l = { "<cmd>lua require'hop'.hint_lines()<CR>", "Line hint" },
		L = { "<cmd>lua require'hop'.hint_char2()<CR>", "Char Alt hint" },
	}, { mode = "v", prefix = "<leader>", noremap = false })
end

return M
