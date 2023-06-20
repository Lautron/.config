-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use('nvim-lua/plenary.nvim')
    use({
        'joshdick/onedark.vim',
        as = 'onedark',
        config = function()
            vim.cmd('colorscheme onedark')
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
    use("theprimeagen/refactoring.nvim")
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
          {'hrsh7th/nvim-cmp'},     -- Required
          {'hrsh7th/cmp-nvim-lsp'}, -- Required
          {'L3MON4D3/LuaSnip'},     -- Required
        }
      }

    use("folke/zen-mode.nvim")
    use("eandrju/cellular-automaton.nvim")
    use { 'SirVer/ultisnips',
        requires = { { 'honza/vim-snippets', rtp = '.' } },
        --config = function()
        --    vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
        --    vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
        --    vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
        --    vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
        --    vim.g.UltiSnipsRemoveSelectModeMappings = 0
        --end
    }

    use({
        "hrsh7th/nvim-cmp",
        requires = {
            {"quangnguyen30192/cmp-nvim-ultisnips"},
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
        },
    })

    use('dhruvasagar/vim-table-mode')
    use('CRAG666/code_runner.nvim')
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
            filetypes={
                markdown=true,
            },
            suggestion = { enabled = false },
            panel = { enabled = false },
        })
      end,
    }

    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua" },
      config = function ()
        require("copilot_cmp").setup()
      end
    }
    -- TODO https://github.com/tpope/vim-surround
    -- TODO https://github.com/Wansmer/treesj
    -- TODO https://github.com/nvim-tree/nvim-tree.lua
    -- TODO https://github.com/phaazon/hop.nvim
end)
