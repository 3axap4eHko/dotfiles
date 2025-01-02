local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("typescript", {
  s("tc", {
    t("try {"), t({"", "  "}),
    i(1, "// code"),
    t({"", "} catch ("}), i(2, "error"), t({") {", "  "}),
    i(0, "// handle error"),
    t({"", "}"}),
  }),

  -- Function snippet
  s("func", {
    t("function "), i(1, "name"), t("("), i(2, "params"), t({") {", "  "}),
    i(0),
    t({"", "}"}),
  }),

  -- Interface snippet
  s("iface", {
    t("interface "), i(1, "InterfaceName"), t({ " {", "  " }),
    i(0, "key: type;"),
    t({ "", "}" }),
  }),

  -- Type alias snippet
  s("type", {
    t("type "), i(1, "TypeName"), t(" = "), i(2, "definition"), t(";"),
  }),
})

