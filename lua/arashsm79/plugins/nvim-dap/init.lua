require("telescope").load_extension("dap")

-- The debugging configuration needs a revamp
-- https://github.com/theHamsta/nvim-dap-virtual-text
-- https://github.com/rcarriga/nvim-dap-ui
-- C/C++
local dap = require("dap")
dap.adapters.cpp = {
    type = "executable",
    name = "cppdbg",
    command = "/home/arashsm79/local/opt/vscode-cpptools/extension/debugAdapters/OpenDebugAD7",
    args = {},
    attach = {
        pidProperty = "processId",
        pidSelect = "ask",
    },
}
vim.cmd(
    [[command! -complete=file -nargs=* DebugC lua require "arashsm79.dap.debugger".start_c_debugger({<f-args>}, "gdb")]]
)

-- Rust
dap.adapters.rust = {
    type = "executable",
    name = "rustdbg",
    command = "/home/arashsm79/local/opt/vscode-cpptools/extension/debugAdapters/OpenDebugAD7",
    args = {},
    attach = {
        pidProperty = "processId",
        pidSelect = "ask",
    },
}
vim.cmd(
    [[command! -complete=file -nargs=* DebugRust lua require "arashsm79.dap.debugger".start_c_debugger({<f-args>}, "gdb", "rust-gdb")]]
)

-- Python
-- require('dap-python').setup('/home/arashsm79/.local/share/venv/debugpy/bin/python')
-- dap.adapters.python = {
--   type = 'executable';
--   command = '/home/arashsm79/.local/share/venv/debugpy/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }
-- dap.configurations.python = {
--   {
--     type = 'python';
--     request = 'launch';
--     name = "Launch file";
--     program = "${file}";
--     pythonPath = (os.getenv('VIRTUAL_ENV') or '/usr' ) .. '/bin/python';
--   },
-- }

-- Set related keybindings
require("arashsm79.keybindings").nvim_dap()
