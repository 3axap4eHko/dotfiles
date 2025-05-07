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
    "L3MON4D3/LuaSnip",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
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
  {
    "windwp/nvim-autopairs",
    enabled = false,
    event = "InsertEnter",
    config = true,
  },
  {
    "saghen/blink.cmp",
    enabled = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    build = "cargo build --release",
    opts = {
      keymap = {
        preset = "default",
        ["<A-j>"] = { "select_next", "fallback" },
        ["<A-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        -- ["<Esc>"] = { "cancel", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        ghost_text = { enabled = false },
        accept = { auto_brackets = { enabled = false } },
        menu = { auto_show = true },
        documentation = { auto_show = false },
        list = {
          selection = { preselect = true, auto_insert = false },
        },
      },
      sources = { default = { "buffer", "snippets", "lsp", "path", "omni" } },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "saghen/blink.compat",
    enabled = false,
    dependencies = { "saghen/blink.cmp" },
  },
}
