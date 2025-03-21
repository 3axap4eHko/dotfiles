local autocmd = vim.api.nvim_create_autocmd

autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.json", "*.jsonl", "*.jnl" },
  command = "set filetype=json",
})
