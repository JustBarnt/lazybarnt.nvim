-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.bigfile_size = 1024 * 1024 * 5
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_statuscolumn = {
  folds_open = true,
  folds_githl = true,
}

local opt = vim.opt

opt.autowrite = false
opt.cmdheight = 0
opt.scrolloff = 16
opt.modeline = false
opt.swapfile = false
