local KW = vim.lsp.protocol.CompletionItemKind.Keyword
local SN = vim.lsp.protocol.CompletionItemKind.Snippet
local ID = vim.lsp.protocol.CompletionItemKind.Variable

local priority = {
  [SN] = 1,
  [KW] = 2,
  [ID] = 3,
}

local function typed()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return line:sub(1, col):match "%w+$" or ""
end

local function strip(s) return s:match "^[^%w]*(.*)" or s end
local function caps(s) return strip(s:gsub("[^%u]", "")) end

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
    accept = { auto_brackets = { enabled = false } },
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
  sources = {
    default = { "snippets", "lsp", "buffer", "path" },
    providers = {
      -- codeium = { name = "Codeium", module = "codeium.blink", async = true },
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
    frecency = {
      enabled = true
    },
    use_proximity = true,
    sorts = {
      -- Sort Priority
      -- 1. All items strict captital letters occurence match, while lowercase mathes captital too, skipping leading non-words
      -- 2. Snippets only exact prefix match over everything
      -- 3. Keywords priority over identifiers
      -- 4. Shortest exact prefix labels must be priority
      "exact",
      function(a, b)
        local q = typed()
        if q:find "%u" then
          local A = caps(a.label):find(q, 1, true)
          local B = caps(b.label):find(q, 1, true)
          if A and not B then return true end
          if B and not A then return false end
        end
      end,
      function(a, b)
        local q = typed()
        if q == "" then return end

        local a_label = strip(a.label):sub(1, #q)
        local b_label = strip(b.label):sub(1, #q)
        local a_priority = priority[a.kind] or 10
        local b_priority = priority[b.kind] or 10

        local a_exact_sensitive = a_label == q
        local b_exact_sensitive = b_label == q
        if a_exact_sensitive ~= b_exact_sensitive then return a_exact_sensitive end

        local a_exact = a_label == q:lower()
        local b_exact = b_label == q:lower()
        if a_exact ~= b_exact then return a_exact end

        if a_priority ~= b_priority then return a_priority < b_priority end
      end,
      "score",
      function(a, b)
        if a.kind == b.kind and #a.label ~= #b.label then return #a.label < #b.label end
      end,
      "sort_text",
    },
  },
}
