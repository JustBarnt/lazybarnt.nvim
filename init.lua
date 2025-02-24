-- bootstrap lazy.nvim, JustVi and your plugins
require("config.lazy")
if vim.g.neovide then
  require("config.neovide")
end
