require('code_runner').setup({
    mode = "tab",
    filetype = {
        python = "venv && python3 -u",
    },
})

vim.keymap.set('n', '<leader>rc', ':RunCode<CR>', { noremap = true, silent = false })
