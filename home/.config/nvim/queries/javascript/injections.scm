; extends

(call_expression
  function: (identifier) @injection.language
  arguments: (template_string (string_fragment) @injection.content)
  (#eq? @injection.language "js")
  (#set! injection.combined)
  (#set! injection.include-children))
