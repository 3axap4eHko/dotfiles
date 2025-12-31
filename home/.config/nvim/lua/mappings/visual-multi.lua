local map = vim.keymap.set

local function vm_map(mode, lhs, rhs, desc)
  map(mode, lhs, rhs, { remap = true, desc = "VM " .. desc })
end

-- Quick entry points
-- vm_map("n", "<C-x>", "<Plug>(VM-Find-Under)", "find next match")
-- vm_map("n", "<leader>f", "<Plug>(VM-Find-Under)", "find next match")
-- vm_map("n", "mm", "<Plug>(VM-Add-Cursor-At-Pos)", "add cursor here")
-- vm_map("n", "<leader>mm", "<Plug>(VM-Add-Cursor-At-Pos)", "add cursor here")
vm_map("n", "<leader>J", "<Plug>(VM-Add-Cursor-Down)", "add cursor below")
vm_map("n", "<leader>K", "<Plug>(VM-Add-Cursor-Up)", "add cursor above")

-- Leader based helpers | normal mode
vm_map("n", "<leader>mj", "<Plug>(VM-Add-Cursor-Down)", "add cursor below")
vm_map("n", "<leader>mk", "<Plug>(VM-Add-Cursor-Up)", "add cursor above")
vm_map("n", "<leader>mJ", "<Plug>(VM-Select-Cursor-Down)", "select cursor below")
vm_map("n", "<leader>mK", "<Plug>(VM-Select-Cursor-Up)", "select cursor above")
vm_map("n", "<leader>ma", "<Plug>(VM-Select-All)", "select all matches")
vm_map("n", "<leader>mF", "<Plug>(VM-Start-Regex-Search)", "start regex search")
vm_map("n", "<leader>m/", "<Plug>(VM-Slash-Search)", "search from / pattern")
vm_map("n", "<leader>mr", "<Plug>(VM-Reselect-Last)", "reselect last session")
vm_map("n", "<leader>mt", "<Plug>(VM-Toggle-Multiline)", "toggle multiline mode")
vm_map("n", "<leader>mw", "<Plug>(VM-Toggle-Whole-Word)", "toggle whole word")
vm_map("n", "<leader>m1", "<Plug>(VM-Toggle-Single-Region)", "toggle single region mode")
vm_map("n", "<leader>mg", "<Plug>(VM-Goto-Regex)", "goto regex match")
vm_map("n", "<leader>mG", "<Plug>(VM-Goto-Regex!)", "goto regex match (skip current)")
--
-- Visual mode helpers (use same <leader>m prefix)
-- vm_map("x", "<leader>ma", "<Plug>(VM-Visual-All)", "visual select all matches")
-- vm_map("x", "<leader>mF", "<Plug>(VM-Visual-Regex)", "visual regex search")
-- vm_map("x", "<leader>mf", "<Plug>(VM-Visual-Find)", "visual find pattern")
-- vm_map("x", "<leader>mc", "<Plug>(VM-Visual-Cursors)", "visual column cursors")
-- vm_map("x", "<leader>ms", "<Plug>(VM-Visual-Add)", "visual add regions")
-- vm_map("x", "<leader>mS", "<Plug>(VM-Visual-Subtract)", "visual subtract regions")
-- vm_map("x", "<leader>mR", "<Plug>(VM-Visual-Reduce)", "visual reduce regions")
