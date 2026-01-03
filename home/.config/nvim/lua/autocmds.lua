local autocmd = vim.api.nvim_create_autocmd

autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then vim.cmd "Nvdash" end
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.json", "*.jsonl", "*.jnl" },
  command = "set filetype=json",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.jinja" },
  command = "set filetype=jinja",
})

-- Undo breaking for certain autocompletions (kept for future use)
-- local autogroup = vim.api.nvim_create_augroup
-- autogroup("UndoAfterComplete", { clear = true })
-- autocmd("CompleteDone", {
--   group = "UndoAfterComplete",
--   callback = function()
--     -- if vim.v.completed_item.user_data and vim.v.completed_item.user_data ~= "" then return end
--     -- local break_undo = vim.api.nvim_replace_termcodes("<C-g>u", true, true, true)
--     -- vim.api.nvim_feedkeys(break_undo, "n", true)
--   end,
-- })
