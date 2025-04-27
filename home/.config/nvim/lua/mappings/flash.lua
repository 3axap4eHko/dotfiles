return {
  {
    "\\",
    mode = { "n", "x", "o" },
    function() require("flash").jump() end,
    desc = "Find: Flash",
  },
  {
    "<C-\\>",
    mode = { "n", "x", "o" },
    function() require("flash").treesitter() end,
    desc = "Find: Flash Treesitter",
  },
  {
    "<A-\\>",
    mode = "o",
    function() require("flash").remote() end,
    desc = "Find: Remote Flash",
  },
  {
    "<leader>fT",
    mode = { "o", "x" },
    function() require("flash").treesitter_search() end,
    desc = "Find: Treesitter",
  },
  {
    "<C-\\>",
    mode = { "c" },
    function() require("flash").toggle() end,
    desc = "Find: Toggle Flash Search",
  },
}
