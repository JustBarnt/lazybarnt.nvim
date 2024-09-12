local M = {}

---@param pattern string
---@return string, number
M.escape_pattern = function(pattern)
  local special_chars = "[]\\.*$^+()?{}|="
  return pattern:gsub("[" .. special_chars .. "]", "\\%1")
end

M.replace_word_instance_under_cursor = function()
  local cpos = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
  local word = vim.fn.expand("<cword>")
  local prompt = "Replace: %s Length:[%d]:"
  vim.ui.input({ prompt = string.format(prompt, word, #word) }, function(input)
    local cmd = "%%s#%s#%s#g"
    if input and #input > 0 then
      vim.cmd(string.format(cmd, word, input))
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), cpos)
    end
  end)
end

return M
