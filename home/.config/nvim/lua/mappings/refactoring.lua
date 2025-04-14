local map = vim.keymap.set
local buf = vim.lsp.buf
local diag = vim.diagnostic

map("n", "<leader>de", diag.open_float, { desc = "LSP: Show error" })
-- map("n", "<leader>dl", diag.setloclist, { desc = "LSP: diagnostic loclist" })

map("n", "<leader>cf", function()
  vim.cmd([[%s/\r//ge]])
  require("conform").format { lsp_fallback = true }
end, { desc = "general format file" })

---

map("n", "]d", diag.goto_next, { desc = "LSP: Next diagnostic" })
map("n", "[d", diag.goto_prev, { desc = "LSP: Previous diagnostic" })

map("n", "<leader>cr", buf.rename, { desc = "LSP: Rename symbol" })
map("n", "<leader>clf", buf.format, { desc = "LSP: Format document" })
map("n", "<leader>cx", buf.references, { desc = "LSP: Find references" })
map("n", "<leader>ca", buf.code_action, { desc = "LSP: Refactoring actions" })

map("n", "<leader>cq", function()
  vim.diagnostic.reset()
  vim.diagnostic.show()
  vim.cmd("LspRestart")
end, { desc = "LSP: Restart LSP server" })

-- map("n", "<leader>S", ":lua require('spectre').toggle()<CR>", { desc = "Toggle Spectre" })
-- map("n", "<leader>sr", ":lua require('spectre').open()<CR>", { desc = "Open Spectre" })
-- map("v", "<leader>sr", ":lua require('spectre').open_visual()<CR>", { desc = "Spectre with selection" })
-- map(
--   "n",
--   "<leader>sw",
--   ":lua require('spectre').open_visual({select_word=true})<CR>",
--   { desc = "Spectre for word under cursor" }
-- )
