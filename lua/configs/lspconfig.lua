require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "gopls", "jdtls", "lua_ls"}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
