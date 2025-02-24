-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("utils.init").wezterm()
local strings = require("utils.strings")

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
