return {
  {
    "<leader>dt",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Diagnostics: Trouble",
  },
  {
    "<leader>db",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Diagnostics: Buffer (Trouble)",
  },
  {
    "<leader>ds",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    desc = "Diagnostics: Symbols (Trouble)",
  },
  {
    "<leader>dr",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    desc = "Diagnostics: LSP Definitions / references / ... (Trouble)",
  },
  {
    "<leader>dL",
    "<cmd>Trouble loclist toggle<cr>",
    desc = "Diagnostics: Location List (Trouble)",
  },
  {
    "<leader>dq",
    "<cmd>Trouble qflist toggle<cr>",
    desc = "Diagnostics: Quickfix List (Trouble)",
  },
}
