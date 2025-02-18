return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = { flavour = "mocha" }
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require "alpha"
      local dashboard = require "alpha.themes.startify"
      dashboard.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
      alpha.setup(dashboard.opts)
    end,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      allowed_dirs = { "~/projects/*" },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    config = function()
      print "Snip"
      require("luasnip").filetype_extend("typescript", { "javascript" })
      require "snippets.typescript"
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    cmd = {
      "Gitsigns",
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
    },
  },
  {
    "kdheepak/lazygit.nvim",
     cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { ignore = false },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      auto_install = true,
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "json",
        "javascript",
        "typescript",
        "rust",
        "toml",
        "yaml",
        "bash",
        "zig"
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      file_ignore_patterns = {
        "node%_modules", -- NodeJS modules
        "%.git",         -- Git metadata
        "%.DS_Store",    -- macOS system files
        "%.lock",        -- Lock files
        "%.log",         -- Log files
        "%.cache",       -- Cache directories
        "%.nx",          -- NX files
        "%.idea",        -- JetBrains IDE files
        "%.vscode",      -- VSCode settings
        "dist",          -- Build outputs
        "build",         -- Build directories
      },
    },
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    opts = {
      size = 15,
      direction = "horizontal",
    },
    cmd = {
      "ToggleTerm",
    },
  },
  {
    "folke/flash.nvim",
    opts = {},
    keys = {
      { "<leader>fs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "<leader>fS", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<leader>fr", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "<leader>fR", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
          keymaps = {
              insert = "<C-g>s",
              insert_line = "<C-g>S",
              normal = "ys",
              normal_cur = "yss",
              normal_line = "yS",
              normal_cur_line = "ySS",
              visual = "S",
              visual_line = "gS",
              delete = "ds",
              change = "cs",
              change_line = "cS",
          },
        })
    end
  }
  -- {
  --   "stevearc/aerial.nvim",
  --   cmd = {
  --     "AerialToggle",
  --   },
  --   config = function()
  --     require("aerial").setup {
  --       backends = { "lsp", "treesitter", "markdown" },
  --       layout = {
  --         default_direction = "right",
  --       },
  --       show_guides = true,
  --       guides = {
  --         mid_item = "├ ",
  --         last_item = "└ ",
  --         nested_top = "│ ",
  --         whitespace = "  ",
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "nvim-pack/nvim-spectre",
  --   config = function()
  --     require("spectre").setup {
  --       highlight = { ui = "String", search = "IncSearch", replace = "DiffChange" },
  --     }
  --   end,
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "nvimtools/none-ls-extras.nvim",
  --   },
  --   config = function()
  --     local null_ls = require "null-ls"
  --
  --     null_ls.setup {
  --       sources = {
  --         null_ls.builtins.formatting.stylua,
  --         null_ls.builtins.formatting.prettier,
  --         null_ls.builtins.completion.spell,
  --         require "none-ls.diagnostics.eslint_d",
  --       },
  --     }
  --   end,
  -- },
}
