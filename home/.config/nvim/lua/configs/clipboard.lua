local M = {}

function M.setup()
  if vim.fn.has("wsl") ~= 1 then
    return
  end
  if vim.fn.executable("win32yank") == 0 then
    return
  end
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank -i --crlf',
      ['*'] = 'win32yank -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank -o --lf',
      ['*'] = 'win32yank -o --lf',
    },
  }
end

return M
