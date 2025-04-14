local vim = vim
local map = vim.keymap.set

local on_attach = function(bufnr)
  local function opts(desc) return { buffer = bufnr, desc = "Git: " .. desc } end

  local gitsigns = require "gitsigns"
  map("n", "gb", function() gitsigns.blame_line { full = true } end, opts "blame")
  map("n", "gp", gitsigns.preview_hunk, opts "preview")
  map("n", "<leader>gd", gitsigns.diffthis, opts "diff")
  map("n", "<leader>gD", function() gitsigns.diffthis "~" end, opts "diff ~")
  map("n", "<leader>gb", gitsigns.toggle_current_line_blame, opts "blame")
end

require("gitsigns").setup {
  on_attach = on_attach,
  update_debounce = 500,
}
