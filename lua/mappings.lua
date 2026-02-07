require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-E>", "<C-X><C-E>")
map("i", "<C-Y>", "<C-X><C-Y>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- hlslens keymap
local kopts = { noremap = true, silent = true }
vim.api.nvim_set_keymap(
  "n",
  "n",
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap(
  "n",
  "N",
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts
)
vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts)

-- telescope
map("n", "<leader>fp", "<cmd>Telescope projects<CR>", { noremap = true, silent = true })

-- List current changes (staged, unstaged, untracked)
map("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", { noremap = true, desc = "Telescope: Git status" })

-- List project-wide commit history
map("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", { noremap = true, desc = "Telescope: Git commits" })

-- List and switch between git branches
map("n", "<leader>fgb", "<cmd>Telescope git_branches<CR>", { noremap = true, desc = "Telescope: Git branches" })

-- List commit history for the current buffer (file)
map("n", "<leader>fgh", "<cmd>Telescope git_bcommits<CR>", { noremap = true, desc = "Telescope: Git buffer commits" })

-- List all files tracked by git
map("n", "<leader>fgf", "<cmd>Telescope git_files<CR>", { noremap = true, desc = "Telescope: Git files" })

-- List stashed changes
map("n", "<leader>fgt", "<cmd>Telescope git_stash<CR>", { noremap = true, desc = "Telescope: Git stash" })

map("n", "<leader>fr", "<cmd>Telescope resume<CR>", { noremap = true, desc = "Telescope: Resume last search" })

vim.keymap.set("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "Format code with conform.nvim" })

local function close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
      local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })

      -- just delete normal buffer, except terminal, tree
      local skip_filetypes = { "NvimTree", "neo-tree" }
      local skip_buftypes = { "terminal" }

      local should_skip = vim.tbl_contains(skip_filetypes, ft)
          or vim.tbl_contains(skip_buftypes, bt)

      if not should_skip then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end

vim.keymap.set("n", "<C-w>O", close_other_buffers, { noremap = true, silent = true, desc = 'Close all other buffers except current' })

local function smart_find_files()
  local path
  local ok, api = pcall(require, "nvim-tree.api")
  
  -- Check if in nvim-tree
  if ok and vim.bo.filetype == "NvimTree" then
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    path = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  else
  -- Neither get current folder
    path = vim.fn.expand("%:p:h")
  end

  require("telescope.builtin").find_files({ cwd = path, prompt_title = "Find Files in " .. path })
end

-- Same with Live Grep (find word)
local function smart_live_grep()
  local path
  local ok, api = pcall(require, "nvim-tree.api")
  
  if ok and vim.bo.filetype == "NvimTree" then
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    path = node.type == "directory" and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  else
    path = vim.fn.expand("%:p:h")
  end

  require("telescope.builtin").live_grep({ search_dirs = { path }, prompt_title = "Grep in " .. path })
end


vim.keymap.set("n", "<leader>fd", smart_find_files, { desc = "Find files in smart dir" })
vim.keymap.set("n", "<leader>fe", smart_live_grep, { desc = "Grep in smart dir" })

