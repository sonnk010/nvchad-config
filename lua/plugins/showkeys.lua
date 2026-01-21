return {
  "nvzone/showkeys",
  lazy = false,
  cmd = "ShowkeysToggle",
  config = function()
    require("showkeys").setup {
      timeout = 1,
      maxkeys = 5,
      position = "top-right",
    }
    vim.cmd("ShowkeysToggle")
  end,
}
