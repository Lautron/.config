require('code_runner').setup({
    mode = "tab",
    filetype = {
        python = "venv && python3 -u",
        go = "go run $file"
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
vim.keymap.set('n', '<leader>ec', function()
    vim.cmd("split")
    vim.cmd("e ~/.config/nvim/after/plugin/code_runner.lua")
    vim.cmd("winc T")
end, { noremap = true, silent = false })
