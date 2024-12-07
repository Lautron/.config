local function xour()
  local current_line = vim.fn.line('.')
  local basename = vim.fn.fnamemodify(vim.fn.bufname('%'), ':t')
  local cmd = string.format('xour.py %s', basename)
  local output = vim.fn.system(cmd)

  local lines = vim.split(output, '\n')
  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line, false, lines)
end

vim.api.nvim_create_user_command('Xour', xour, { nargs = 0})

-- Function to extract and open the path inside the parentheses
function open_path_in_parentheses()
  -- Get the line under the cursor
  local line = vim.fn.getline(".")

  -- Extract the path inside parentheses
  local path = line:match("%(([^)]+)%)")

  if path then
    -- Open the file in a new buffer
    vim.cmd("tabe " .. path)
  else
    print("No path found inside parentheses")
  end
end

-- Keybinding to open the path inside parentheses
vim.api.nvim_set_keymap('n', '<leader>gf', ':lua open_path_in_parentheses()<CR>', { noremap = true, silent = true })

