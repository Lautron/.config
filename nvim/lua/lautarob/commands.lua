local function xour()
  local current_line = vim.fn.line('.')
  local basename = vim.fn.fnamemodify(vim.fn.bufname('%'), ':t')
  local cmd = string.format('xour.py %s', basename)
  local output = vim.fn.system(cmd)

  local lines = vim.split(output, '\n')
  vim.api.nvim_buf_set_lines(0, current_line - 1, current_line, false, lines)
end

vim.api.nvim_create_user_command('Xour', xour, { nargs = 0})
