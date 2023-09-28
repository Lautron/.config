-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use('nvim-lua/plenary.nvim')
    use({
        'navarasu/onedark.nvim',
        config = function()
            local onedark = require('onedark')
            onedark.setup {
                style = 'cool'
            }
            onedark.load()
        end
    })

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        requires = {
            "MDeiml/tree-sitter-markdown",
        }
    }
    use("nvim-treesitter/playground")
    use("theprimeagen/harpoon")
    use{
        "theprimeagen/refactoring.nvim",
        config = function()
          require("refactoring").setup()
        end,
    };
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("nvim-treesitter/nvim-treesitter-context");

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},             -- Required
          {                                      -- Optional
            'williamboman/mason.nvim',
          },
          {'williamboman/mason-lspconfig.nvim'}, -- Optional

          -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
        }
      }

    use("folke/zen-mode.nvim")
    use("eandrju/cellular-automaton.nvim")
    --use { 'SirVer/ultisnips',
    --    requires = { { 'honza/vim-snippets', rtp = '.' } },
    --    --config = function()
    --    --    vim.g.UltiSnipsJumpForwardTrigger="<tab>"
    --    ----    vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
    --    ----    vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
    --    ----    vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
    --    ----    vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
    --    ----    vim.g.UltiSnipsRemoveSelectModeMappings = 0
    --    --end
    --}

    --use({
    --    "hrsh7th/nvim-cmp",
    --    requires = {
    --        {"quangnguyen30192/cmp-nvim-ultisnips"},
    --        { 'hrsh7th/cmp-buffer' },
    --        { 'hrsh7th/cmp-path' },
    --        { 'saadparwaiz1/cmp_luasnip' },
    --        { 'hrsh7th/cmp-nvim-lsp' },
    --        { 'hrsh7th/cmp-nvim-lua' },
    --    },
    --})

    use('dhruvasagar/vim-table-mode')
    use('CRAG666/code_runner.nvim')
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- https://github.com/Wansmer/treesj
    use({
      'Wansmer/treesj',
      requires = { 'nvim-treesitter' },
    })

    -- https://github.com/nvim-tree/nvim-tree.lua
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional
      },
    }

    -- https://github.com/kylechui/nvim-surround
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- https://github.com/stevearc/aerial.nvim
    use {
      'stevearc/aerial.nvim',
      config = function() require('aerial').setup({
          -- optionally use on_attach to set keymaps when aerial has attached to a buffer
          on_attach = function(bufnr)
              vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
              vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
          end,
          manage_folds = true,
      }) end
    }
    -- https://github.com/numToStr/Comment.nvim
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- https://github.com/ggandor/leap.nvim
    use {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end
    }

    -- https://github.com/lewis6991/gitsigns.nvim
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    -- optional https://github.com/kevinhwang91/nvim-bqf
    use{
        'anuvyklack/pretty-fold.nvim',
        config = function()
            require('pretty-fold').setup()
        end
    }

    use {
        'https://github.com/milisims/foldhue.nvim',
        config = function()
            require('foldhue').enable()
        end
    }

end)
