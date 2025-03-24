return {
  flavour = "mocha",
  integrations = {
    cmp = true,
    dashboard = true,
    flash = true,
    fzf = true,
    indent_blankline = { enabled = true },
    lsp_trouble = true,
    mason = true,
    markdown = true,
    mini = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  }
}
