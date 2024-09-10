vim.keymap.set("n", "<leader>mc", function()
  vim.cmd([[
  s#- \[ \]#- [x]
  ]])
  vim.cmd([[nohlsearch]])
end, { desc = "Mark TODO Completed", silent = true })

vim.keymap.set("n", "<leader>mC", function()
  vim.cmd([[
  s#- \[x\]#- [ ]
  ]])
  vim.cmd([[nohlsearch]])
end, { desc = "Mark TODO Not Completed", silent = true })
