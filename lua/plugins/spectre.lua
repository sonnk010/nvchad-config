return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Spectre",
  keys = {
    {
      "<leader>pe",
      function()
        require("spectre").open()
      end,
      desc = "Open Spectre",
    },
  },
  config = function()
    require("spectre").setup()
  end,
}
-- some comment
-- Some code
-- and some pice
