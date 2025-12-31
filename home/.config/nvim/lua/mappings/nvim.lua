local map = vim.keymap.set
local cmd = vim.cmd
local fn = vim.fn
local api = vim.api
local opts = { noremap = true, silent = true }

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general yank whole file" })

map("n", "<leader>unt", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>unr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>mc", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

local opener = "xdg-open"
if fn.has "mac" == 1 then
  opener = "open"
elseif fn.has "wsl" == 1 then
  opener = "explorer.exe"
end

map("n", "gx", function()
  local url = fn.expand "<cWORD>"
  if url:match "^https?://" then
    fn.jobstart({ opener, url }, { detach = true })
  else
    print("Not a valid URL: " .. url)
  end
end, { desc = "Open URL under cursor", noremap = true, silent = true })

---
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "<Tab>", function() require("nvchad.tabufline").next() end, { desc = "buffer goto next" })
map("n", "<S-Tab>", function() require("nvchad.tabufline").prev() end, { desc = "buffer goto prev" })
map("n", "<C-q>", function() require("nvchad.tabufline").close_buffer() end, { desc = "buffer close" })
map("n", "<A-q>", function() require("nvchad.tabufline").closeAllBufs() end, { desc = "buffer close" })

map("n", "<leader>mW", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map(
  "n",
  "<leader>mw",
  function() cmd("WhichKey " .. fn.input "WhichKey: ") end,
  { desc = "whichkey query lookup" }
)

---

map("i", "<A-o>", "<Esc>A;<CR>", opts)
map("n", "<A-o>", "A;<CR><Esc>", opts)

map("n", "<leader>yf", function()
  local file = fn.expand "<cfile>"
  fn.setreg("+", file)
  print("Copied to clipboard: " .. file)
end, { desc = "Yank filename to the clipboard", noremap = true, silent = true })

map("n", "<A-v>", "<C-v>", { noremap = true })
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map("x", "ro", [[:'<,'>!sort <CR>]], { desc = "Replace: sort selected lines", silent = true })
map("x", "rs", [[:s/\%V]], { desc = "Replace: in selected text" })
map("x", "rr", function()
  cmd "normal! \"zy"
  local yanked = fn.getreg "z"
  local esc = fn.escape(yanked, [[\^$.*\/\[\]%]])
  api.nvim_feedkeys(":%s/" .. esc .. "/", "n", false)
end, { desc = "Replace: search/replace selected text" })

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-i>", "<C-i>zz")

map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Navigate to left pane" })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Navigate to bottom pane" })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Navigate to top pane" })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Navigate to right pane" })

map("t", "<C-h>", "<Nop>", { desc = "Disable in terminal" })
map("t", "<C-j>", "<Nop>", { desc = "Disable in terminal" })
map("t", "<C-k>", "<Nop>", { desc = "Disable in terminal" })
map("t", "<C-l>", "<Nop>", { desc = "Disable in terminal" })

map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move current line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move current line down" })

map("n", "<A-h>", "<<^", { desc = "Decrease indentation" })
map("n", "<A-l>", ">>^", { desc = "Increase indentation" })
map("v", "<A-h>", "<gv^", { desc = "Decrease indentation" })
map("v", "<A-l>", ">gv^", { desc = "Increase indentation" })

map("i", "<A-h>", "<Esc><<I", { desc = "Decrease indentation" })
map("i", "<A-l>", "<Esc>>>I", { desc = "Increase indentation" })

map("v", "<S-A-j>", "y'<Pgv", { desc = "Copy selected lines up" })
map("v", "<S-A-k>", "y'>pgv", { desc = "Copy selected lines down" })
map("n", "<S-A-j>", "yyP", { desc = "Copy current line up" })
map("n", "<S-A-k>", "yyp", { desc = "Copy current line down" })

map("n", "<leader>ypr", ":let @+=expand('%')<CR>", { desc = "Copy file relative path" })
map("n", "<leader>ypa", ":let @+=expand('%:p')<CR>", { desc = "Copy file absolute path" })

map("i", " ", " <C-g>u", opts)
for _, ch in ipairs { ".", ",", ";", ":", "!", "?", "(", "[", "{", "'", "\"", "`", "$", "%", "_" } do
  map("i", ch, ch .. "<C-g>u", opts)
end
