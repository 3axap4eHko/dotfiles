local telescope = require "telescope"

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
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git",
      "--glob=!node_modules",
      "--glob=!dist",
      "--glob=!build",
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
})

telescope.load_extension "ui-select"
