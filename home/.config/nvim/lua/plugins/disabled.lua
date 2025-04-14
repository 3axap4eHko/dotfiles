return {
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
    opts = function(_, opts)
      require "configs.edgy"
    end,
  },
  {
    "saghen/blink.cmp",
    enabled = false,
    dependencies = "rafamadriz/friendly-snippets",
    vesion = "*",
    build = "cargo build --release",
    opts = {
      keymap = {
        preset = "default",
        ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
        ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
        ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
        ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
        ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
        ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
        ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
        ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
        ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
        ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
      },
      completion = {
        menu = {
          draw = {
            columns = {
              { "item_idx" },
              { "kind_icon" },
              {
                "label",
                "label_description",
                gap = 1,
              },
            },
            components = {
              item_idx = {
                text = function(ctx) return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx) end,
                highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
              },
            },
          },
        },
      },
    },
  }
}
