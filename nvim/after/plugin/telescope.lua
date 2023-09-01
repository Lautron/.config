local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fH', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', builtin.command_history, {})
vim.keymap.set('n', '<leader>ft', builtin.filetypes, {})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})

require('telescope').setup{
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "venv",
      "requirements.txt",
    }
  }
}

----vim.keymap.set('n', '<Leader>fg', ':GFiles<CR>', { silent = true })
----vim.keymap.set('n', '<Leader>ff', ':Rg<CR>', { silent = true })
----vim.keymap.set('n', '<Leader>fm', ':Maps<CR>', { silent = true })
--vim.keymap.set('n', '<Leader>fs', ':Snippets<CR>', { silent = true })
----vim.keymap.set('n', '<Leader>ft', ':Filetypes<CR>', { silent = true })
---- vim.keymap.set('n', '<Leader>fc', ':Commands<CR>', { silent = true })
---- vim.keymap.set('n', '<Leader>fH', ':Helptags<CR>', { silent = true })
--vim.keymap.set('n', '<Leader>hh', ':History<CR>', { silent = true })
--vim.keymap.set('n', '<Leader>h:', ':History:<CR>', { silent = true })
