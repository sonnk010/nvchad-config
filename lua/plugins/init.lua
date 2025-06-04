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

  {
    -- provides better syntax highlighting and code understanding by using abstract syntax trees.
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
        set_highlight = true,
        handlers = {
          cursor = fasle,
          diagnostic = true,
          gitsigns = true, -- Requires gitsigns
          handle = true,
          search = true, -- Requires hlslens
          ale = false, -- Requires ALE tb
        }
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    event = "BufRead",
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        signs_staged = {
          add = { text = '┃' },
          change = { text = '┃' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      }
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = "Go to next Git hunk" })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = "Go to previous Git hunk" })

          -- Actions
          map('n', '<leader>gs', gitsigns.stage_hunk, { desc = "Stage current hunk" })
          map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "Reset current hunk" })

          map('v', '<leader>gs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { desc = "Stage selected hunks in visual mode" })

          map('v', '<leader>gr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { desc = "Reset selected hunks in visual mode" })

          map('n', '<leader>gS', gitsigns.stage_buffer, { desc = "Stage entire buffer" })
          map('n', '<leader>gR', gitsigns.reset_buffer, { desc = "Reset entire buffer" })
          map('n', '<leader>gp', gitsigns.preview_hunk, { desc = "Preview current hunk" })
          map('n', '<leader>gi', gitsigns.preview_hunk_inline, { desc = "Preview current hunk inline" })

          map('n', '<leader>gb', function()
            gitsigns.blame_line({ full = true })
          end, { desc = "Show full blame info for current line" })

          map('n', '<leader>gd', gitsigns.diffthis, { desc = "Diff current buffer with HEAD" })

          map('n', '<leader>gD', function()
            gitsigns.diffthis('~')
          end, { desc = "Diff current buffer with HEAD~" })

          map('n', '<leader>gQ', function()
            gitsigns.setqflist('all')
          end, { desc = "Set quickfix list with all hunks" })
          map('n', '<leader>gq', gitsigns.setqflist, { desc = "Set quickfix list with hunks" })

          -- Toggles
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
          map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

          -- Text object
          map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = "Select current hunk (text object)" })
        end
      }
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
