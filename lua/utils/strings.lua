local M = {}

---@param pattern string
---@return string, number
M.escape_pattern = function(pattern)
  local special_chars = "[]\\.*$^+()?{}|="
  return pattern:gsub("[" .. special_chars .. "]", "\\%1")
end

return M
