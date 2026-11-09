return {
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
    ghost_text = { enabled = true },
    keyword = { range = "prefix" },
    accept = { auto_brackets = { enabled = true } },
    menu = {
      auto_show = true,
      draw = {
        treesitter = { "lsp" },
        columns = {
          { "kind_icon" },
          { "label", width = { max = 30 } },
          { "label_description", width = { max = 50 } },
          { "kind" },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    list = {
      selection = { preselect = true, auto_insert = false },
    },
  },
  signature = { enabled = true },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
    frecency = {
      enabled = true
    },
    use_proximity = true,
    sorts = { "score", "sort_text" },
  },
}
