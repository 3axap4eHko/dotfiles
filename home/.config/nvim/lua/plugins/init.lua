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
    "lewis6991/gitsigns.nvim",
    config = function() require "configs.gitsigns" end,
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
    "saghen/blink.pairs",
    version = "*", -- Use the latest version
    build = "cargo build --release",
    opts = {
      mappings = {
        enabled = true,
        pairs = {}, -- Customize pairs if needed
      },
      highlights = {
        enabled = true,
        groups = {
          "BlinkPairsOrange",
          "BlinkPairsPurple",
          "BlinkPairsBlue",
        },
        matchparen = {
          enabled = true,
          group = "MatchParen",
        },
      },
      debug = false,
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = { "InsertEnter", "CmdLineEnter" },
    version = "1.*",
    build = "cargo build --release",
    opts = function ()
      return require "configs.blink"
    end,
    opts_extend = { "sources.default", "sources.providers" },
  },
  {
    "kylechui/nvim-surround",
    version = "^3.1.1",
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
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    config = function() require "configs.lspconfig" end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = { "NvimTreeFindFile", "NvimTreeToggle" },
    opts = require "mappings.nvim-tree",
    config = function() require "configs.nvim-tree" end,
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function() require "configs.telescope" end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = false,
        },
      },
    },
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
