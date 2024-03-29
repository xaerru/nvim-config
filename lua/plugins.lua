local use = require("packer").use

require("packer").startup(function()
    use({ "wbthomason/packer.nvim" }) -- Package manager
    use({ "nvim-lua/plenary.nvim" })
    use({
        "neovim/nvim-lspconfig",
        module = "lspconfig",
        setup = function()
            -- Reason for neovim default start screen/splash screen disappearing
            vim.defer_fn(function()
                require("packer").loader("nvim-lspconfig")
                vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
            end, 0)
        end,
        config = function()
            require("lsp")
        end,
    })
    use({
        "folke/trouble.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("plugins.trouble").load()
        end,
    })
    use({
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
    })
    use({
        "rafamadriz/friendly-snippets",
        after = "nvim-lspconfig",
    })
    use({
        "L3MON4D3/LuaSnip",
        after = "friendly-snippets",
        config = function()
            local default = { history = true, updateevents = "TextChanged,TextChangedI" }
            require("luasnip").config.set_config(default)
            require("luasnip/loaders/from_vscode").load()
        end,
    })
    use({
        "hrsh7th/nvim-cmp",
        after = "LuaSnip",
        config = function()
            require("plugins.cmp").load()
        end,
    })
    use({
        "hrsh7th/cmp-nvim-lsp",
        after = "nvim-cmp",
    })
    use({
        "saadparwaiz1/cmp_luasnip",
        after = "cmp-nvim-lsp",
    })
    use({
        "hrsh7th/cmp-path",
        after = "cmp_luasnip",
    })
    use({
        "hrsh7th/cmp-buffer",
        after = "cmp-path",
    })
    use({
        "hrsh7th/cmp-nvim-lua",
        after = "cmp-buffer",
    })
    use({
        "lukas-reineke/cmp-rg",
        after = "cmp-nvim-lua",
    })
    use({
        "andersevenrud/cmp-tmux",
        after = "cmp-rg",
    })
    use({
        "hrsh7th/cmp-cmdline",
        event = "CmdlineEnter",
    })
    use({
        "hrsh7th/cmp-calc",
        after = "cmp-tmux",
    })
    use({
        "tzachar/cmp-fuzzy-path",
        requires = { "tzachar/fuzzy.nvim" },
        after = "cmp-calc",
    })
    use({
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("plugins.autopairs").load()
        end,
    })
    use({
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        module = "telescope.finders",
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
        },
        config = function()
            require("plugins.telescope").load()
        end,
    })
    use({
        "kyazdani42/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = function()
            require("plugins.nvimtree").load()
        end,
    })
    use({
        "RRethy/nvim-base16",
        event = "VimEnter",
        config = function()
            vim.cmd([[ colorscheme base16-default-dark ]])
        end,
    })
    use({
        "tjdevries/express_line.nvim",
        requires = { "lewis6991/gitsigns.nvim" },
        after = "nvim-base16",
        config = function()
            require("statusline")
        end,
    })
    use({
        "akinsho/bufferline.nvim",
        after = "express_line.nvim",
        config = function()
            require("plugins.bufferline").load()
        end,
    })
    use({
        "akinsho/toggleterm.nvim",
        config = function()
            require("plugins.toggleterm").load()
        end,
        after = "bufferline.nvim",
    })
    use({
        "nvim-treesitter/nvim-treesitter",
        after = "plenary.nvim",
        config = function()
            require("plugins.treesitter").load()
        end,
    })
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    })
    use({
        "mfussenegger/nvim-ts-hint-textobject",
        config = function()
            require("tsht").config.hint_keys = { "a", "o", "e", "i", "d", "h", "t", "n" }
        end,
        after = "nvim-treesitter",
    })
    use({
        "norcalli/nvim-colorizer.lua",
        after = "nvim-treesitter",
        config = function()
            require("colorizer").setup()
        end,
    })
    use({
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({
                trigger_events = { "InsertLeave", "CursorHold", "FocusLost" },
                execution_message = {
                    message = ""
                },
            })
        end,
        after = "nvim-treesitter",
    })
    use({
        "preservim/nerdcommenter",
        after = "nvim-treesitter",
    })
    use({
        "chaoren/vim-wordmotion",
        after = "nvim-treesitter",
    })
    use({
        "folke/which-key.nvim",
        after = "nvim-treesitter",
        config = function()
            require("plugins.whichkey").load()
        end,
    })
    use({
        "lewis6991/gitsigns.nvim",
        after = "plenary.nvim",
        config = function()
            require("plugins.gitsigns").load()
        end,
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        after = "nvim-base16",
    })
    -- TODO: Make bufferline autosave the order and persist the not saved buffers
    use({
        "rmagatti/auto-session",
        after = "nvim-base16",
        config = function()
            require("auto-session").setup({
                auto_save_enabled = true,
                auto_restore_enabled = true,
                auto_session_suppress_dirs = { "~/" },
                log_level = "error",
            })
        end,
    })
end)
