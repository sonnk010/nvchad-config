-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  theme_toggle = {
    "catppuccin",
    "catppuccin-latte",
  },
  --transparency = true,
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
  hl_override = {
    NvimTreeCursorLine = {
      bg = "#25243b",
    }
  }
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = true,
    order = {
      "treeOffset",
      "buffers",
      "tabs",
    },
    modules = {
      buffers = function()
        local api = vim.api
        local utils = require "nvchad.tabufline.utils"
        local opts_tb = require("nvconfig").ui.tabufline
        local cur_buf = api.nvim_get_current_buf
        local buffers = {}

        vim.t.bufs = vim.tbl_filter(api.nvim_buf_is_valid, vim.t.bufs)

        for i, nr in ipairs(vim.t.bufs) do
          local is_cur = cur_buf() == nr
          local bg = api.nvim_get_hl(0, { name = is_cur and "TbBufOn" or "TbBufOff" }).bg

          local border_hl = "TbBorder" .. (is_cur and "On" or "Off")
          api.nvim_set_hl(0, border_hl, {
            fg = is_cur and 0x7aa2f7 or bg,
            bg = bg,
          })

          local border = string.format("%%#%s#%s", border_hl, is_cur and "▎" or " ")
          table.insert(buffers, border .. utils.style_buf(nr, i, opts_tb.bufwidth - 1))
        end

        return table.concat(buffers) .. utils.txt("%=", "Fill")
      end,
    },
  },
  statusline = {
    modules = {
      --get relative file path
      file = function()
        local buftype = vim.bo.buftype
        local filetype = vim.bo.filetype

        if buftype == "terminal" or filetype == "NvimTree" then
          return ""
        end
        local utils = require "nvchad.stl.utils"
        local x = utils.file()

        local relpath = vim.fn.expand "%:."
        if relpath == "" then
          return ""
        end

        return "%#StText# " .. x[1] .. " " .. relpath .. " "
      end,
    },
  },
  telescope = {
    style = "bordered",
  },
}

M.cheatsheet = {
  theme = "simple",
}

return M
