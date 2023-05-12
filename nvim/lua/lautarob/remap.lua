
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>nt", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- CUSTOM
-- open PDF file in Zathura
vim.keymap.set('n', '<Leader>op', ":!zathura \"%:p:r.pdf\" & disown<cr>:redraw!<cr>", {silent = true, noremap = true})

-- open a new Alacritty window
vim.keymap.set('n', '<Leader>ot', ":!alacritty &;disown<cr>:redraw!<cr>", {silent = true, noremap = true})

-- open Ranger file manager in a new Alacritty window running the Fish shell
vim.keymap.set('n', '<Leader>or', ":!alacritty -e fish -C 'ranger' &;disown<cr>:redraw!<cr>", {silent = true, noremap = true})

-- compile markdown to PDF using pandoc
vim.keymap.set('n', '<Leader>cl', ":w <bar> :!pandoc --toc --toc-depth=4 -f markdown -t latex '%' -o '%:r.pdf'<CR>", { silent = true, noremap = true })

vim.keymap.set('n', '<Leader>q', ":q<CR>", { silent = true, noremap = true })
