local map = vim.keymap.set

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"
  local spectre = require "spectre"

  api.config.mappings.default_on_attach(bufnr)

  -- remove a default
  -- vim.keymap.del("n", "<C-]>", { buffer = bufnr })

  map("n", "<ESC>", api.tree.close, { desc = "nvim-tree: Close", buffer = bufnr })

  map("n", "h", function()
    local node = api.tree.get_node_under_cursor()
    print(node.absolute_path);
    if node.name ~= ".." then
      if node.type == "directory" then
        if node.open then
          api.node.open.edit()
        else
          api.node.navigate.parent()
        end
      else
        api.node.navigate.parent()
      end
    end
  end, { desc = "nvim-tree: Collape and go to parent", buffer = bufnr })

  map("n", "l", function()
    local node = api.tree.get_node_under_cursor()
    if node.type == "directory" then
      if node.open then
        vim.cmd("normal! j")
      else
        api.node.open.edit()
      end
    end
  end, { desc = "nvim-tree: Expand and go sibling", buffer = bufnr })

  map("n", "<leader>r", function()
    local node = api.tree.get_node_under_cursor()
    if node then
      local path = node.absolute_path
      api.tree.close()
      local relative_path = vim.fn.fnamemodify(path, ":.")
      spectre.open {
        is_insert_mode = true,
        path = relative_path .. "/**/*",
      }
    end
  end, { desc = "nvim-tree: Open Spectre" })

  map("n", "<leader>w", function()
    local node = api.tree.get_node_under_cursor()
    if node then
      local path = node.absolute_path
      api.tree.close()
      local relative_path = vim.fn.fnamemodify(path, ":.")
      require("telescope.builtin").live_grep { search_dirs = { relative_path } }
    end
  end, { desc = "nvim-tree: Live Grep with Telescope" })
end

require("nvim-tree").setup {
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
  },
}
