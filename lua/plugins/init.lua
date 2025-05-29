return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup({
        datadir = vim.fn.stdpath("data") .. "/site/projects",
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "Makefile", "package.json", ".project" },
        exclude_dirs = {},
        change_detection_methods = { "lsp", "pattern" },
      })
      require("telescope").load_extension("projects")
    end,
  },
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Desktop', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
    config = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
      require('auto-session').setup {
        log_level = 'info',
        auto_session_enable_last_session = false,
        auto_session = true,
        auto_save = true,
        auto_restore = true,
        lazy_support = true,
        session_lens = { load_on_setup = true },
      }
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = false,
    config = function()
      require("scrollbar").setup({
        show = true,
        hide_if_all_visible = true,
      })
    end,
  },
  {
    -- glance at matched information, include highlight scrollbar
    'kevinhwang91/nvim-hlslens',
    lazy = false,
    dependencies = { "petertriho/nvim-scrollbar" }, -- ensuring nvim-scrollbar is loaded first
    config = function()
      require("scrollbar.handlers.search").setup({ -- integrate with nvim-scrollbar
      })
    end
  }
}
