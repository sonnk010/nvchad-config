return {
  "gbprod/yanky.nvim",
  opts = {},
  keys = {
    { "<leader>mp", function() require("telescope").extensions.yank_history.yank_history({}) end, desc = "Open Yank History", },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text", },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Cursor", },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Yanked Text Before Cursor", },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Selection", },
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
    { "]g", "<Plug>(YankyCycleForward)" },
    { "[g", "<Plug>(YankyCycleBackward)" },
  }
}
