
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
vim.keymap.set('n', '<Leader>cl', ":w <bar> :!pandoc.sh '%'<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<Leader>cd', ":w <bar> :!pandoc-draft.sh '%'<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<Leader>mm', ":!markmap '%' -o /tmp/markmap.html && qutebrowser /tmp/markmap.html<CR>", { silent = true, noremap = true })

vim.keymap.set('n', '<Leader>q', ":q<CR>", { silent = true, noremap = true })
vim.keymap.set('n', '<Leader>so', ":so $MYVIMRC<CR>", { silent = true, noremap = true })

vim.keymap.set('n', '<leader>at', '<cmd>AerialToggle<CR>')
vim.keymap.set('n', '<leader>an', '<cmd>AerialNavToggle<CR>')
vim.keymap.set('n', '<leader>fmi', ':set foldmethod=indent<cr>')
vim.keymap.set('n', '<leader>fmi', ':set foldmethod=indent<cr>')
vim.keymap.set('n', ',/', ":nohlsearch<CR>", { silent = true })

vim.keymap.set('n', 'gdh', ":diffget //2<CR>", { silent = true })
vim.keymap.set('n', 'gdl', ":diffget //3<CR>", { silent = true })

vim.keymap.set('n', '<leader>o', ":only<CR>", { silent = true })
vim.keymap.set('x', "<leader>re", ":Refactor extract<cr>")
vim.keymap.set('x', "<leader>rv", ":Refactor extract_var<cr>")

vim.keymap.set('n', "<leader>sj", ":lua require('treesj').toggle()<cr>")

--vim.keymap.set('n', "<leader>xo", ":Xour<cr>")
vim.api.nvim_set_keymap('n', '<leader>xo', [[:normal! o<CR>:Xour<CR>]],
    { noremap = true, silent = true }
)

vim.keymap.set('n', '<Leader>ida', function()
        vim.cmd([[:%s/\(<!-- \)\@<!!\[\(.*\)\?\](.*)\({.*}\)\?/<!-- \0 -->/g]])
    end, { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>iea', function()
        vim.cmd([[:%s/<!-- \(!\[\](.*)\({.*}\)\?\) -->/\1/g]])
    end, { noremap = true, silent = true })


local function toggle_md_comment()
    local current_line = vim.fn.getline('.')
    if string.match(current_line, "^<!--") then
        vim.cmd([[:s/<!-- \(!\[\](.*)\({.*}\)\?\) -->/\1/g]])
        vim.cmd(":nohlsearch")
    else
        vim.cmd([[:s/\(<!-- \)\@<!!\[\(.*\)\?\](.*)\({.*}\)\?/<!-- \0 -->/g]])
        vim.cmd(":nohlsearch")
    end
end

vim.keymap.set('n', '<Leader>it', function() toggle_md_comment() end, { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>cp', ":Copilot panel<cr>", { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>ca', function() require("copilot.panel").accept() end, { noremap = true, silent = true })
