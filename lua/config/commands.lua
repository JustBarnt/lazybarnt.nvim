vim.api.nvim_create_user_command("FastAction", function()
  local fa = require("fastaction")
  fa.code_action()
end, { bang = false, desc = "Activate Fast Actions" })

vim.api.nvim_create_user_command("FastActionRange", function()
  local fa = require("fastaction")
  fa.range_code_action()
end, { bang = false, desc = "Activate Fast Actions Within Visual Selection" })
