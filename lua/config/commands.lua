local api = vim.api
local string_utils = require("utils.strings")

vim.api.nvim_create_user_command("DecrementNumbers", function(opts)
  local args = vim.split(opts.args, " ")

  if #args ~= 2 then
    print("Usage: AdjustPosNumbers <pattern> <number>")
    return
  end

  local pattern = args[1]:gsub("=", "\\=") or 'Pos\\="'
  local number = tonumber(args[2])

  if not number then
    print("Please provide a valid number as the argument.")
    return
  end

  -- Handle the range
  local range = (opts.line1 ~= opts.line2) and (opts.line1 .. "," .. opts.line2) or opts.line1

  -- Perform the substitution within the specified range
  vim.cmd(range .. "s/\\v(" .. pattern .. "\\zs\\d+)/\\=submatch(0) - " .. number .. "/")
end, { nargs = "*", range = true, desc = "Decrements any numbers found within provided <pattern> by the <value> " })
