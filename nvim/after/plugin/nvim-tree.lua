-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
    sort = {
        sorter = "modification_time",
    },
    actions = {
        open_file = {
            quit_on_open = true
        },
    },
})

vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<cr>", { silent = true })
