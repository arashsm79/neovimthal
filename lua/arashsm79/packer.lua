require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("neovim/nvim-lspconfig")
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "ray-x/cmp-treesitter",
        },
        config = function()
            require("arashsm79.plugins.nvim-cmp")
        end,
    })
    use({
        "hoob3rt/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("arashsm79.plugins.lualine")
        end,
    })
    use({
        "lewis6991/gitsigns.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("arashsm79.plugins.gitsigns")
        end,
    })
    use({
        "L3MON4D3/LuaSnip",
        config = function()
            require("arashsm79.plugins.luasnip")
        end,
    })
    use({
        "kyazdani42/nvim-tree.lua",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("arashsm79.plugins.nvim-tree")
        end,
    })
    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
        config = function()
            require("arashsm79.plugins.telescope")
        end,
    })
    use("tomasiser/vim-code-dark")
    use({
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("arashsm79.plugins.treesitter")
        end,
    })
    use("lambdalisue/suda.vim")
    use({
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("arashsm79.plugins.nvim-bufferline")
        end,
    })
    use({
        "akinsho/toggleterm.nvim",
        config = function()
            require("arashsm79.plugins.nvim-toggleterm")
        end,
    })
    use({
        "folke/which-key.nvim",
        config = function()
            require("arashsm79.plugins.which-key")
        end,
    })
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("arashsm79.plugins.nvim-autopairs")
        end,
    })
    use({
        "phaazon/hop.nvim",
        config = function()
            require("arashsm79.plugins.nvim-hop")
        end,
    })
    use("lukas-reineke/indent-blankline.nvim")
    use("LnL7/vim-nix")
    use({
        "lervag/vimtex",
        config = function()
            require("arashsm79.plugins.vimtex")
        end,
    })
    use({
        "iurimateus/luasnip-latex-snippets.nvim",
        config = function()
            require("arashsm79.plugins.luasnip-latex-snippets")
        end,
        ft = "tex",
    })
    use({
        "glacambre/firenvim",
        config = function()
            require("arashsm79.plugins.firenvim")
        end,
    })
    use({
        "lewis6991/impatient.nvim",
        config = function()
            require("arashsm79.plugins.impatient")
        end,
    })
    use({
        "~/Playground/rust-tools.nvim",
    })
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("arashsm79.plugins.todo-comments")
        end,
    })
    use({
        "xiyaowong/nvim-transparent",
        config = function()
            require("arashsm79.plugins.transparent")
        end,
    })
    use({
        "stevearc/dressing.nvim",
        config = function()
            require("arashsm79.plugins.dressing")
        end,
    })
    use({
        "ellisonleao/glow.nvim",
        config = function()
            require("arashsm79.plugins.glow")
        end,
    })
    use({
        "norcalli/nvim-colorizer.lua",
    })
    use({
        "mfussenegger/nvim-dap",
        config = function()
            require("arashsm79.plugins.nvim-dap")
        end,
    })
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("arashsm79.plugins.nvim-dap-ui")
        end,
    })
    use({
        "theHamsta/nvim-dap-virtual-text",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("arashsm79.plugins.nvim-dap-virtual-text")
        end,
    })
    use({
        "nvim-telescope/telescope-dap.nvim",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("arashsm79.plugins.telescope-dap")
        end,
    })
    use({
        "nvim-lua/plenary.nvim",
    })
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
        config = function()
            require("arashsm79.plugins.winbar")
        end,
    }
end)
