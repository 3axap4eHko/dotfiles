return {
  {
    "<leader>fq",
    mode = { "n", "x", "o" },
    function() require("flash").jump() end,
    desc = "Find: Flash",
  },
  {
    "<leader>ft",
    mode = { "n", "x", "o" },
    function() require("flash").treesitter() end,
    desc = "Find: Flash Treesitter",
  },
  {
    "<leader>fr",
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
    "<c-s>",
    mode = { "c" },
    function() require("flash").toggle() end,
    desc = "Find: Toggle Flash Search",
  },
}
