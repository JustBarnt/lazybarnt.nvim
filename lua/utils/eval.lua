local M = {}

M.line = function()
  local line = vim.api.nvim_get_current_line()
  local ex, err = load(line)()

  if ex then
    ex()
  elseif err then
    print("Error in Lua:" .. err)
  end
end

M.selection = function()
  local s_pos = vim.fn.getpos("'<")
  local e_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(s_pos[2], e_pos[2])
  ---@diagnostic disable-next-line: param-type-mismatch
  local code = table.concat(lines, "\n")

  local ex, err = load(code)()

  if ex then
    print(ex())
  elseif err then
    print("Error in Lua:" .. err)
  end
end

M.doc = function()
  vim.cmd("source %")
end

return M
