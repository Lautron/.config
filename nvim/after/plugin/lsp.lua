-- LSP setup using Neovim 0.11 native API
-- See :help lspconfig-nvim-0.11

-- Mason (LSP server installer)
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'pylsp',
        'lua_ls',
        'gopls',
    },
    handlers = {
        function(server_name)
            vim.lsp.enable(server_name)
        end,
    },
})

-- LSP keymaps (on attach)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
        local opts = { buffer = args.buf, remap = false }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
    end,
})

-- Diagnostic signs and display
vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.HINT] = 'H',
            [vim.diagnostic.severity.INFO] = 'I',
        },
    },
    float = { border = 'rounded' },
})

-- Global LSP capabilities (applied to all servers)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
vim.lsp.config['*'] = {
    capabilities = capabilities,
}

-- Lua language server: recognize `vim` global
vim.lsp.config.lua_ls = vim.tbl_deep_extend('force', vim.lsp.config.lua_ls or {}, {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
        },
    },
})

-- LuaSnip
local ls = require('luasnip')
ls.config.setup({ enable_autosnippets = true })
require('luasnip.loaders.from_vscode').lazy_load({ paths = '~/.config/nvim/snippets/vscode/' })

vim.keymap.set('n', '<leader>es', function()
    vim.cmd('split')
    require('luasnip.loaders').edit_snippet_files({ ft_filter = function(ft) return ft ~= 'all' end })
    vim.cmd('winc T')
    vim.cmd('so $MYVIMRC')
end)

-- nvim-cmp
local cmp = require('cmp')

local function luasnip_tab()
    if cmp.visible() then
        cmp.confirm({ select = true })
    elseif ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end

local function luasnip_shift_tab()
    if cmp.visible() then
        cmp.select_prev_item()
    elseif ls.jumpable(-1) then
        ls.jump(-1)
    end
end

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 3 },
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
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(luasnip_tab, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(luasnip_shift_tab, { 'i', 's' }),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
    },
})
