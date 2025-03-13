local map = vim.keymap.set

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  -- remove a default
  -- vim.keymap.del("n", "<C-]>", { buffer = bufnr })

  map("n", "<ESC>", api.tree.close, { desc = "nvim-tree: Close" })
  map("n", "h", api.node.navigate.parent, { desc = "nvim-tree: Go to parent" })
  map("n", "l", api.node.navigate.sibling.last, { desc = "nvim-tree: Go to last" })
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  filters = {
    git_ignored = false,
  },
  renderer = {
    root_folder_label = ":~:s?$?",
    group_empty = true,
  },
  view = {
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local w_h = math.min(80, screen_w - 2)
        local s_h = math.min(42, screen_h - 2)
        local center_x = (screen_w - w_h) / 2
        local center_y = ((vim.opt.lines:get() - s_h) / 5) - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = w_h,
          height = s_h,
        }
      end,
    },
    width = function() return math.floor(vim.opt.columns:get() * 5) end,
  },
})
