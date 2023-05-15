require('code_runner').setup({
    mode = "tab",
    filetype = {
        python = "venv && python3 -u",
    },
    project = {
    ["~/Documents/Facultad/año3/PdP/lab/lab2/grupo09_lab02_2023"] = {
       name = "PdP java",
       description = "Named entity project",
       command = "make"
      }
    }
})

vim.keymap.set('n', '<leader>rc', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
