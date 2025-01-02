local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },

    javascript = { "deno_fmt" },
    javascriptreact = { "deno_fmt" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },

    json = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
    mdx = { "prettier" },

    sh = { "shfmt" },
    go = { "gofmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
