vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.opt.number = true
vim.opt.wrap = false

-- UFO folding
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- install ripgrep for searching
-- install luarocks package manage for Lua
-- set capslock to ecs: gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"
-- install magick for display image: wget https://imagemagick.org/archive/binaries/magick
-- install lazygit: https://github.com/jesseduffield/lazygit/tree/master?tab=readme-ov-file#installation
-- setup git config --global core.editor "nvim" - to prevent opening GNU nano editor in nvim
-- for jdtls with old java version ex: 17. Fix in https://github.com/mason-org/mason.nvim/issues/1826#issuecomment-2621118063

