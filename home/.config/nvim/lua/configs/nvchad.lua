local term = require("nvchad.term")
local display = term.display

local map = vim.keymap.set
local termId = "floatTerm";
local termPos = "float";
local float_opts = {
  width = 1,
  height = 0.9,
  border = "double"
}

map({ "n" }, "<A-`>", function() term.toggle { pos = termPos, id = termId, float_opts = float_opts } end, { desc = "Term: Toggle" })

local openFile = function ()
  local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
  if f ~= "" then
    require("nvchad.term").toggle { pos = termPos, id = termId, float_opts = float_opts }
    vim.schedule(function()
      vim.cmd("e " .. f)
    end)
  end
end

term.display = function(o)
  display(o);

  local function opts(desc)
    return { buffer = o.buf, desc = "Term: " .. desc }
  end

  map({ "", "n", "t" }, "<A-`>", function() term.toggle { pos = termPos, id = termId, float_opts = float_opts } end, opts "Toggle")
  map("n", "gf", function() openFile() end, opts "Toggle")
  map("t", "<C-h>", "<C-h>", opts "Pass to terminal")
  map("t", "<C-j>", "<C-j>", opts "Pass to terminal")
  map("t", "<C-k>", "<C-k>", opts "Pass to terminal")
  map("t", "<C-l>", "<C-l>", opts "Pass to terminal")

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = o.buf,
    callback = function()
      local win = vim.fn.bufwinid(o.buf)
      if win ~= -1 then
        local win_config = vim.api.nvim_win_get_config(win)
        if win_config.relative ~= "" then
          vim.api.nvim_win_close(win, true)
        end
      end
    end,
  })

  map({ "", "t", "n" }, "<C-LeftMouse>", function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<LeftMouse>", true, false, true), "n", false)
    vim.defer_fn(function() openFile() end, 10)
  end, opts "Toggle")
end
