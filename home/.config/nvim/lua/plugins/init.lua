return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { flavour = "mocha" } },
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
      -- suppressed_dirs = {  },
      -- log_level = 'debug',
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
    -- lazy = not vim.g.is_git,
  },
  {
    "tpope/vim-fugitive",
    -- lazy = not vim.g.is_git,
    cmd = {
      "Git",
    },
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
    -- lazy = not vim.g.is_directory,
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
        "bash"
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
    "github/copilot.vim",
    config = true,
  },
  {
    "stevearc/aerial.nvim",
    cmd = {
      "AerialToggle",
    },
    config = function()
      require("aerial").setup {
        backends = { "lsp", "treesitter", "markdown" },
        layout = {
          default_direction = "right",
        },
        show_guides = true,
        guides = {
          mid_item = "├ ",
          last_item = "└ ",
          nested_top = "│ ",
          whitespace = "  ",
        },
      }
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup {
        highlight = { ui = "String", search = "IncSearch", replace = "DiffChange" },
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
