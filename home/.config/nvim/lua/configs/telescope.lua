local telescope = require "telescope"

local ts_select_dir_for_grep = function(prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local fb = require("telescope").extensions.file_browser
  local live_grep = require("telescope.builtin").live_grep
  local current_line = action_state.get_current_line()

  fb.file_browser({
    files = false,
    depth = false,
    attach_mappings = function(prompt_bufnr)
      require("telescope.actions").select_default:replace(function()
        local entry_path = action_state.get_selected_entry().Path
        local dir = entry_path:is_dir() and entry_path or entry_path:parent()
        local relative = dir:make_relative(vim.fn.getcwd())
        local absolute = dir:absolute()

        live_grep({
          results_title = relative .. "/",
          cwd = absolute,
          default_text = current_line,
        })
      end)

      return true
    end,
  })
end

telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = " ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.87,
      height = 0.80,
    },
    mappings = {
      n = { ["q"] = require("telescope.actions").close },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
      mappings = {
        i = {
        },
        n = {
        },
      },
    },
  },
  pickers = {
    live_grep = {
      mappings = {
        i = {
          ["<C-f>"] = ts_select_dir_for_grep,
        },
        n = {
          ["<C-f>"] = ts_select_dir_for_grep,
        },
      },
    },
  },
  file_ignore_patterns = {
    "node%_modules", -- NodeJS modules
    "%.git",         -- Git metadata
    "%.DS_Store",    -- macOS system files
    "%.lock",        -- Lock files
    "%.log",         -- Log files
    "%.cache",       -- Cache directories
    "%.nx",          -- NX files
    "%.idea",        -- JetBrains IDE files
    "%.vscode",      -- VSCode settings
    "dist",          -- Build outputs
    "build",         -- Build directories
  },
})

telescope.load_extension "ui-select"
-- telescope.load_extension "file_browser"
