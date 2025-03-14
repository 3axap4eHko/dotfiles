local map = vim.keymap.set

local spectre = require("spectre")
local api = require("nvim-tree.api")

local function my_on_attach(bufnr)

  api.config.mappings.default_on_attach(bufnr)

  -- remove a default
  -- vim.keymap.del("n", "<C-]>", { buffer = bufnr })

  map("n", "<ESC>", api.tree.close, { desc = "nvim-tree: Close", buffer = bufnr })
  map("n", "h", api.node.navigate.parent, { desc = "nvim-tree: Go to parent", buffer = bufnr })
  map("n", "l", api.node.navigate.sibling.last, { desc = "nvim-tree: Go to last", buffer = bufnr })

  map("n", "<leader>r", function()
    local node = api.tree.get_node_under_cursor()
    if node then
      local path = node.absolute_path;
      api.tree.close();
      local relative_path = vim.fn.fnamemodify(path, ":.")
      spectre.open({
        path = relative_path .. "/**/*",
      })
    end
  end, { desc = "nvim-tree: Open Spectre" })

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
  git = {
    enable = false,
  }
})
