if vim.fn.has("win32") == 1 then
  local ori_fnameescape = vim.fn.fnameescape
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.fnameescape = function(...)
    ---@type string
    local result = ori_fnameescape(...)
    return result:gsub("\\", "/")
  end
end

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.neovide then
  require("config.neovide")
end
