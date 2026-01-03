local map = vim.keymap.set

local function selected_nodes(bufnr, api)
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line == 0 or end_line == 0 then
    return {}
  end
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  start_line = math.max(1, math.min(start_line, line_count))
  end_line = math.max(1, math.min(end_line, line_count))

  vim.cmd([[exe "normal! \<Esc>"]])

  local win = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(win)
  local nodes = {}
  local seen = {}

  for lnum = start_line, end_line do
    local ok = pcall(vim.api.nvim_win_set_cursor, win, { lnum, 0 })
    if ok then
      local node = api.tree.get_node_under_cursor()
      if node and node.absolute_path and node.name ~= ".." then
        local key = node.absolute_path
        if not seen[key] then
          seen[key] = true
          nodes[#nodes + 1] = node
        end
      end
    end
  end

  pcall(vim.api.nvim_win_set_cursor, win, cursor)
  return nodes
end

local function confirm_bulk(action, nodes)
  if #nodes == 0 then
    return false
  end
  local lines = {}
  local max_list = 20
  for i, node in ipairs(nodes) do
    if i > max_list then
      lines[#lines + 1] = ("... and %d more"):format(#nodes - max_list)
      break
    end
    lines[#lines + 1] = vim.fn.fnamemodify(node.absolute_path, ":.")
  end
  local prompt = ("%s %d item(s)?\n%s"):format(action, #nodes, table.concat(lines, "\n"))
  return vim.fn.confirm(prompt, "&No\n&Yes", 1) == 2
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  api.config.mappings.default_on_attach(bufnr)

  -- remove a default
  -- vim.keymap.del("n", "<C-]>", { buffer = bufnr })

  map("n", "<ESC>", api.tree.close, { desc = "nvim-tree: Close", buffer = bufnr })

  map("n", "h", function()
    local node = api.tree.get_node_under_cursor()
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

  map("v", "d", function()
    local nodes = selected_nodes(bufnr, api)
    if not confirm_bulk("Delete", nodes) then
      return
    end
    local remove_file = require("nvim-tree.actions.fs.remove-file")
    for _, node in ipairs(nodes) do
      remove_file.remove(node)
    end
    local explorer = require("nvim-tree.core").get_explorer()
    if explorer then
      explorer:reload_explorer()
    end
  end, { desc = "nvim-tree: Delete selection", buffer = bufnr })

  map("v", "D", function()
    local nodes = selected_nodes(bufnr, api)
    if not confirm_bulk("Trash", nodes) then
      return
    end
    local trash = require("nvim-tree.actions.fs.trash")
    for _, node in ipairs(nodes) do
      trash.remove(node)
    end
    local explorer = require("nvim-tree.core").get_explorer()
    if explorer then
      explorer:reload_explorer()
    end
  end, { desc = "nvim-tree: Trash selection", buffer = bufnr })

  map("n", "<leader>r", function()
    local node = api.tree.get_node_under_cursor()
    if node then
      local path = node.absolute_path
      api.tree.close()
      local relative_path = vim.fn.fnamemodify(path, ":.")
      require("spectre").open {
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
  },
  git = {
    enable = false,
  },
}
