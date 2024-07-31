-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_statuscolumn = {
  folds_open = true,
  folds_githl = true,
}

local opt = vim.opt

opt.shell = "nu"
opt.number = true
opt.relativenumber = true
opt.cmdheight = 0
opt.scrolloff = 16
opt.wrap = false
opt.modeline = false
opt.guicursor = "n-r-cr:hor20,i-ci:ver25,v-ve:block-blinkwait175-blinkoff150-blinkon175"
