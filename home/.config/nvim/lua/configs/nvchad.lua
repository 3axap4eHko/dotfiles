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

  map({ "", "t", "n" }, "<C-LeftMouse>", function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<LeftMouse>", true, false, true), "n", false)
    vim.defer_fn(function() openFile() end, 10)
  end, opts "Toggle")
end
