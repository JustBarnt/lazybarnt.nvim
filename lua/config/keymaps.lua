-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("utils.init").wezterm()
local strings = require("utils.strings")
local eval = require("utils.eval")

vim.keymap.set("n", "<leader>pt", require("nvchad.themes").open, { desc = "Pick New Theme", silent = true })
vim.keymap.set("n", "<leader>el", eval.line, { desc = "Evaluate line as Lua", silent = true })
vim.keymap.set("v", "<leader>es", eval.selection, { desc = "Evaluate selection as Lua", silent = true })
vim.keymap.set("n", "<leader>ed", eval.doc, { desc = "Evaluate document as Lua", silent = true })

vim.keymap.set("n", "<Esc>", function()
  vim.cmd("NoiceDismiss")
  vim.cmd("nohlsearch")
end, { desc = "Clear Notifications and Hl Searches" })

vim.keymap.set(
  { "n", "v" },
  "<leader>rw",
  strings.replace_word_under_cursor,
  { desc = "Replace `<cword>` instance in buffer" }
)
