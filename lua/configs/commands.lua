-- Copy commands
vim.api.nvim_create_user_command("CopyFilename", function()
  local filename = vim.fn.expand("%:t")
  vim.fn.setreg("+", filename)
  vim.notify("Copied filename: " .. filename)
end, {})

vim.api.nvim_create_user_command("CopyAbsolutePath", function()
  local abs_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", abs_path)
  vim.notify("Copied absolute path: " .. abs_path)
end, {})

vim.api.nvim_create_user_command("CopyRelativePath", function()
  local rel_path = vim.fn.expand("%:.")
  vim.fn.setreg("+", rel_path)
  vim.notify("Copied relative path: " .. rel_path)
end, {})

-- Autocmd to run :SessionLoad on startup (only when no file args)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        vim.cmd("SessionLoad")
      end, 100)
    end
  end,
})

-- Prevent open new buffer when start
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.bufname("%") == "" and vim.bo.filetype == "" then
      vim.cmd("bwipeout")
    end
  end,
})
