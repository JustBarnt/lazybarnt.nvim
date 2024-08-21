vim.g.mapleader = " "

vim.g.bigfile_size = 1024 * 1024 * 5
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_statuscolumn = {
  folds_open = true,
  folds_githl = true,
}

local opt = vim.opt

opt.shortmess = "ltToOCFIc"
opt.autowrite = false
opt.cmdheight = 0
opt.scrolloff = 16
opt.modeline = false
opt.swapfile = false

if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("nu")
end
