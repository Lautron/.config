local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "pylsp",
    "lua_ls",
    "gopls",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.extend_lspconfig({
  sign_text = true,
  float_border = 'rounded',
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})

vim.diagnostic.config({
    virtual_text = true
})

-- Make sure you setup `cmp` after lsp-zero

local ls = require("luasnip")
ls.config.setup({ enable_autosnippets = true })
--require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/snippets/snipmate/" })
require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/snippets/vscode/" })

local cmp_action = require('lsp-zero').cmp_action()

vim.keymap.set("n", "<leader>es", function()
    vim.cmd("split")
    require("luasnip.loaders").edit_snippet_files( { ft_filter = function(ft) return ft ~= "all" end })
    vim.cmd("winc T")
    vim.cmd("so $MYVIMRC")
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

cmp.setup({
    sources = {
        --{name = "copilot"},
        {name = 'luasnip'},
        {name = 'nvim_lsp'},
        {name = 'buffer', keyword_length = 3},
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    preselect = cmp.PreselectMode.None,
    mapping = {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<Tab>'] = cmp_action.luasnip_jump_forward(),
            ['<S-Tab>'] = cmp_action.luasnip_jump_backward(),
            ['<C-n>'] = cmp.mapping.select_next_item(), -- Navigate to the next suggestion
            ['<C-p>'] = cmp.mapping.select_prev_item(), -- Navigate to the previous suggestion

    },
    formatting = lsp.cmp_format({details = true}),
})
