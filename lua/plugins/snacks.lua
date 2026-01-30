return {
  "folke/snacks.nvim",
  lazy = false,
  ---@type snacks.Config
  opts = {
    lazygit = {
      configure = true,
    },
  },
  keys = {
    {
      "<leader>gg",
      function()
        Snacks.lazygit.open()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
  },
}
