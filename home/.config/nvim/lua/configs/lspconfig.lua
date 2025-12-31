local map = vim.keymap.set
local buf = vim.lsp.buf
local diag = vim.diagnostic

local orig = vim.lsp.handlers["textDocument/definition"]
vim.lsp.handlers["textDocument/definition"] = function(err, result, ctx, config)
  orig(err, result, ctx, config)
  vim.cmd "normal! zz"
end

local on_attach = function(_, bufnr)
  local function opts(desc) return { buffer = bufnr, desc = "LSP: " .. desc } end

  map("n", "gD", buf.declaration, opts "Go to declaration")
  map("n", "gd", buf.definition, opts "Go to definition")
  map("n", "gi", buf.implementation, opts "Go to implementation")
  map("n", "grx", buf.references, opts "Show references")
  map("n", "grn", buf.rename, opts "Rename symbol")
  map("n", "<leader>cf", function() buf.format { async = true } end, opts "Format document")
  map("n", "grf", buf.code_action, opts "Refactoring actions")

  map({ "n", "v" }, "g.", buf.code_action, opts "Code action")

  map("n", "<leader>sh", buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function() print(vim.inspect(buf.list_workspace_folders())) end, opts "List workspace folders")

  map("n", "gtd", buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", buf.rename, opts "NvRenamer")

  map("n", "<leader>re", diag.open_float, opts "Show error")
  map("n", "<leader>rd", diag.setloclist, opts "diagnostic loclist")

  map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts "Next diagnostic")
  map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts "Previous diagnostic")

  -- if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) end
end

local on_init = function(client)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local base_capabilities = vim.lsp.protocol.make_client_capabilities()

base_capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}
base_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local capabilities = require("blink.cmp").get_lsp_capabilities(base_capabilities)

-- Reduce LSP logging for better performance
vim.lsp.set_log_level "ERROR"

local x = vim.diagnostic.severity

vim.diagnostic.config {
  virtual_text = { prefix = "" },
  signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "single",
    source = "if_many",
  },
}

local servers = {
  "ts_ls",
  "rust_analyzer",
  "clangd",
  "html",
  "cssls",
  "lua_ls",
  "jsonls",
  "bashls",
  "marksman",
  "gopls",
}

local server_configs = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
}

local shared = { on_attach = on_attach, on_init = on_init, capabilities = capabilities }

for _, name in ipairs(servers) do
  local override = server_configs[name] or {}
  local cfg = vim.tbl_deep_extend("force", shared, override)
  vim.lsp.config(name, cfg)
  vim.lsp.enable(name)
end
