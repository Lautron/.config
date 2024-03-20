return {
    'nvim-lua/plenary.nvim',
    {
        'navarasu/onedark.nvim',
        config = function()
            local onedark = require('onedark')
            onedark.setup {
                style = 'cool'
            }
            onedark.load()
        end
    },

    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        dependencies = {
            "MDeiml/tree-sitter-markdown",
        }
    },
    "nvim-treesitter/playground",
    "theprimeagen/harpoon",
    {
        "theprimeagen/refactoring.nvim",
        config = function()
            require("refactoring").setup()
        end,
    },
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "nvim-treesitter/nvim-treesitter-context",
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
        }
    },

    "folke/zen-mode.nvim",
    "eandrju/cellular-automaton.nvim",

    'dhruvasagar/vim-table-mode',
    'CRAG666/code_runner.nvim',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    -- https://github.com/Wansmer/treesj
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter' },
    },

    -- https://github.com/nvim-tree/nvim-tree.lua
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    },

    -- https://github.com/kylechui/nvim-surround
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },

    -- https://github.com/stevearc/aerial.nvim
    {
        'stevearc/aerial.nvim',
        config = function()
            require('aerial').setup({
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
                end,
                manage_folds = true,
            })
        end
    },
    -- https://github.com/numToStr/Comment.nvim
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    -- https://github.com/ggandor/leap.nvim
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end
    },

    -- https://github.com/lewis6991/gitsigns.nvim
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    },

    -- optional https://github.com/kevinhwang91/nvim-bqf
    {
        'anuvyklack/pretty-fold.nvim',
        config = function()
            require('pretty-fold').setup()
        end
    },

    {
        'https://github.com/milisims/foldhue.nvim',
        config = function()
            require('foldhue').enable()
        end
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
        dependencies = {
            "zbirenbaum/copilot-cmp",
            config = function()
                require("copilot_cmp").setup()
            end
        },
    },

    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup()
        end,
    },
    {
        'huynle/ogpt.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
    },
}
