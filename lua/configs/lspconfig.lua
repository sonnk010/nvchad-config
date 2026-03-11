require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "gopls", "jdtls", "lua_ls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

local map = vim.keymap.set

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
