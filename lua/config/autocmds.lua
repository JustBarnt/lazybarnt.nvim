local set = vim.opt_local
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
  pattern = { "gitcommit", "markdown", "txt", "norg" },
  desc = "Enable spell checking for certain filetypes",
  callback = function()
    set.number = false
    set.conceallevel = 3
    set.concealcursor = "nc"
    set.linebreak = true
    set.breakat = " ^I!@*-+;:,./?"
    set.breakindent = true
  end,
})
