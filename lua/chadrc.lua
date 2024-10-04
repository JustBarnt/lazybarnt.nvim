---@class ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula-evondev",
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
  },
  -- cmp = {
  --   lspkind_text = true,
  --   style = "default",
  -- },
  telescope = { style = "borderless" },
  tabufline = {
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },
}

M.nvdash = {
  load_on_startup = true,
}

M.term = {
  winopts = { number = false, relativenumber = true },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "single",
  },
}

M.lsp = { signature = true }

M.cheatsheet = { theme = "simple" }

return M
