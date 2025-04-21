return {
  { "hrsh7th/nvim-cmp", enabled = false },
  {
    "hrsh7th/cmp-buffer",
    enabled = false,
  },
  {
    "hrsh7th/cmp-path",
    enabled = false,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    enabled = false,
  },
  {
    "hrsh7th/cmp-cmdline",
    enabled = false,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.surround",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "folke/edgy.nvim",
    enabled = false,
    opts = function(_, opts) require "configs.edgy" end,
  },
}
