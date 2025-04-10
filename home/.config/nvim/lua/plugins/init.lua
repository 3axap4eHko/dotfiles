return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = require "configs.catppuccin",
  },
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
      require "configs.nvchad"
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = "nvim-lua/plenary.nvim",
  },
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
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    keys = { {
      "<leader>glz",
      "<cmd>LazyGit<cr>",
      desc = "LazyGit",
    } },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "L3MON4D3/LuaSnip",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
        --     Old text                    Command         New text
        -- --------------------------------------------------------------------------------
        --     surr*ound_words             ysiw)           (surround_words)
        --     *make strings               ys$"            "make strings"
        --     [delete ar*ound me!]        ds]             delete around me!
        --     remove <b>HTML t*ags</b>    dst             remove HTML tags
        --     'change quot*es'            cs'"            "change quotes"
        --     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
        --     delete(functi*on calls)     dsf             function calls
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.treesitter",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "clangd",
        "cssls",
        "html",
        "lua_ls",
        "marksman",
        "rust_analyzer",
        "ts_ls",
        "eslint",
      },
      automatic_installation = false,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require "configs.lspconfig" end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    -- cmd = { "NvimTreeFindFile", "NvimTreeToggle" },
    opts = require("mappings.nvim-tree"),
    config = function ()
        require "configs.nvim-tree"
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function() require "configs.telescope" end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "folke/flash.nvim",
    opts = {},
    keys = require "mappings.flash",
  },
  {
    "folke/trouble.nvim",
    opts = require "configs.trouble",
    cmd = "Trouble",
    keys = require "mappings.trouble",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },
}
