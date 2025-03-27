return {
    'nvim-lua/plenary.nvim',
    lazy = true,
    {
        'navarasu/onedark.nvim',
        config = function()
            local onedark = require('onedark')
            onedark.setup {
                style = 'cool'
            }
            onedark.load()
        end,
        lazy = false
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cx",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        dependencies = {
            "MDeiml/tree-sitter-markdown",
        },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    "lua",
                    "python",
                    "markdown",
                    "markdown_inline",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
        event = "VeryLazy",
    },
    {
        "theprimeagen/harpoon",
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>ha", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
        end
    },
    {
        "theprimeagen/refactoring.nvim",
        config = function()
            require("refactoring").setup()
        end,
        cmd = 'Refactor',
    },
    {
        "mbbill/undotree",
        event = "VeryLazy",
    },
    {
        "tpope/vim-fugitive",
        event = "VeryLazy",
        cmd = { "G", "Gdiff" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
        },
    },
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
    },
    {
        "eandrju/cellular-automaton.nvim",
        event = "VeryLazy",
    },
    {
        'dhruvasagar/vim-table-mode',
        event = "VeryLazy"
    },
    {
        'CRAG666/code_runner.nvim',
        config = function()
            require('code_runner').setup({
                mode = "tab",
                filetype = {
                    python = "venv && python3 -u",
                    go = "go run $file",
                    sql = "runsql < $file"
                },
                project = {
                    ["/home/lautarob/Documents/Facultad/año3/IS1/proyecto/code/back"] = {
                        name = "LaCosa",
                        command = "venv; pytest -s"
                    },
                }
            })

            vim.keymap.set('n', '<leader>rc', ':RunCode<CR>', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>er', function()
                vim.cmd("split")
                vim.cmd("e ~/.config/nvim/after/plugin/code_runner.lua")
                vim.cmd("winc T")
            end, { noremap = true, silent = false })
        end,
        keys = {
            '<leader>rc',
            '<leader>rf',
            '<leader>er',
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
            vim.opt.termguicolors = true

            require("nvim-tree").setup({
                sort = {
                    sorter = "modification_time",
                },
                actions = {
                    open_file = {
                        quit_on_open = true
                    },
                },
                update_focused_file = {
                    enable = true,
                }
            })

            vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<cr>", { silent = true })
        end,
        keys = {
            "<leader>nt"
        }
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
        event = "VeryLazy",
    },
    {
        'stevearc/aerial.nvim',
        config = function()
            require('aerial').setup({
                on_attach = function(bufnr)
                    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
                end,
                manage_folds = false,
            })
        end,
        -- cmd = {
        --     "AerialToggle",
        --     "AerialNavToggle",
        -- },
        -- keys = {
        --     "<leader>at",
        --     "<leader>an"
        -- }
        lazy = false
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
        keys = {
            { "gc", mode = "v" },
            { "gb", mode = "v" },
            "gcc",
            "gbb",
        }
    },
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end,
        keys = {
            "s"
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
        event = "VeryLazy",
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
        keys = {
            "<leader>sj"
        }
    },
    {
        "jackMort/ChatGPT.nvim",
        keys = {
            "<leader>co",
            "<leader>ce",
        },
        cmd = {
            "ChatGPT",
            "ChatGPTEditWithInstructions",
            "ChatGPTCompleteCode"
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "openai_get_key.sh",
                openai_params = {
                    model = "gpt-4o-mini",
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    max_tokens = 8000,
                    temperature = 0,
                    top_p = 1,
                    n = 1,
                },
                openai_edit_params = {
                    model = "gpt-4o-mini",
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    temperature = 0,
                    top_p = 1,
                    n = 1,
                },
                config_paths = { "/home/lautarob/.config/nvim/prompts/actions.json" }
            })

            vim.keymap.set('n', '<leader>co', ':ChatGPT<CR>', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>ce', ':ChatGPTEditWithInstructions<CR>',
                { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>cr', ':ChatGPTRun ', { noremap = true, silent = false })
            vim.keymap.set('n', '<leader>cc', ':ChatGPTCompleteCode ', { noremap = true, silent = false })
        end,
    },
    {
        'serenevoid/kiwi.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {
            {
                name = "personal",
                path = "/home/lautarob/Documents/wiki",
            }
        },
        keys = {
            { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
            { "T",          ":lua require(\"kiwi\").todo.toggle()<cr>",     desc = "Toggle Markdown Task" }
        },
        lazy = true
    },
    {
        'mhartington/formatter.nvim',
        config = function()
            local util = require "formatter.util"

            require('formatter').setup({
                filetype = {
                    sql = {
                        function()
                            return {
                                exe = "sqlfluff",
                                args = {
                                    "fix",
                                    "--disable-progress-bar",
                                    "--nocolor",
                                    "-",
                                },
                                stdin = true,
                                ignore_exitcode = true,
                            }
                        end
                    },
                    json = {
                        require("formatter.filetypes.json").jq,
                    }
                }
            })
        end,
        cmd = {
            "Format"
        },
        keys = {
            "<leader>fe"
        }
    },
    {
        "folke/zen-mode.nvim",
        event = "VeryLazy"
    },
    {
        "hat0uma/csvview.nvim",
        config = function()
            require('csvview').setup()
        end,
        keys = {
            "<leader>cv"
        },
        cmd = {
            "CsvViewToggle"
        }
    },
    {
        "olrtg/nvim-emmet",
        config = function()
            vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
        end,
        keys = {
            { "<leader>xe", mode = "n" },
            { "<leader>xe", mode = "v" },
        }
    },
    {
        "luckasRanarison/tailwind-tools.nvim",
        name = "tailwind-tools",
        build = ":UpdateRemotePlugins",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {},
        ft = { "html", "css", "javascript", "typescript" },
        event = "InsertEnter",
    },
    {
        "git-time-metric/gtm-vim-plugin",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "benfowler/telescope-luasnip.nvim"
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fH', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fc', builtin.command_history, {})
            vim.keymap.set('n', '<leader>ft', builtin.filetypes, {})
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})

            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = {
                        "node_modules",
                        "venv",
                        "requirements.txt",
                    }
                }
            }

            require('telescope').load_extension('luasnip')


            vim.keymap.set('n', '<leader>fs', function()
                vim.cmd('Telescope luasnip')
            end, {})
        end,
        keys = {
            '<leader>ff',
            '<leader>fg',
            '<leader>fH',
            '<leader>fc',
            '<leader>ft',
            '<leader>fk',
        }
    },
    {
        'stevearc/oil.nvim',
        --- @module 'oil'
        --- @type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = {
            { "echasnovski/mini.icons",      opts = {} },
            { "nvim-tree/nvim-web-devicons", opts = {} },
        },
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    {
        "LunarVim/bigfile.nvim",
        opts = {
            filesize = 2
        },
    },
    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
        end
    },
    { "let-def/texpresso.vim" },
    -- {
    --     "iurimateus/luasnip-latex-snippets.nvim",
    --     -- vimtex isn't required if using treesitter
    --     requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    -- },
    {
        "evesdropper/luasnip-latex-snippets.nvim",
    },
}

-- {
--     "mfussenegger/nvim-lint",
--     config = function()
--         require('lint').linters_by_ft = {
--             sql = { 'sqlfluff' },
--         }
--
--         vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--             callback = function()
--                 require("lint").try_lint()
--             end,
--         })
--     end,
-- },
