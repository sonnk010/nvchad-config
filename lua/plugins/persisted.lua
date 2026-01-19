-- autosave session, window stage
local plugins = {
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    lazy = false,
    config = function()
      require("persisted").setup {
        autoload = true,
        autosave = true,
        use_git_branch = false,
        autostart = true,
        follow_cwd = true,
        on_autoload_no_session = function()
          vim.notify "No existing session to load."
        end,
      }

      local api = require "nvim-tree.api"

      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedSavePre",
        callback = function()
          api.tree.close()
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedLoadPost",
        callback = function()
          api.tree.toggle({ focus = false, find_file = true })
        end,
      })

      require("telescope").load_extension "persisted"
      require("telescope").setup {
        extensions = {
          persisted = {
            layout_config = { width = 0.55, height = 0.55 },
          },
        },
      }
    end,
  },
}

return plugins
