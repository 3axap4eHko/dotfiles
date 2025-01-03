local args = vim.fn.argv()
local is_directory = #args == 1 and vim.fn.isdirectory(args[1]) == 1

return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { flavour = "mocha" } },
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function()
  --     require("luasnip").filetype_extend("typescript", {"javascript"})
  --     require "snippets.typescript"
  --   end
  -- },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = not is_directory,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css"
      },
    },
  },
  {
    "github/copilot.vim",
    config = true
  },
  {
    "stevearc/aerial.nvim",
    cmd = {
      "AerialToggle"
    },
    config = function()
      require("aerial").setup({
        -- Customize options here
        backends = { "lsp", "treesitter", "markdown" },
        layout = {
          default_direction = "right",
        },
        show_guides = true,
        guides = {
          mid_item = "├ ",
          last_item = "└ ",
          nested_top = "│ ",
          whitespace = "  ",
        },
      })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup({
        highlight = { ui = "String", search = "IncSearch", replace = "DiffChange" },
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    lazy = false,
  },
}
