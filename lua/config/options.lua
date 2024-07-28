-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_picker = "telescope"

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cmdheight = 0
opt.scrolloff = 16
opt.wrap = false
opt.laststatus = 3
