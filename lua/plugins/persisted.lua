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
