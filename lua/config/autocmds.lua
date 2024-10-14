local api = vim.api
local set = vim.opt_local
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
  pattern = { "gitcommit", "markdown", "txt", "norg" },
  desc = "Enable spell checking for certain filetypes",
  callback = function()
    set.number = false
    set.relativenumber = false
    set.conceallevel = 3
    set.concealcursor = "nc"
    set.linebreak = true
    set.breakat = " ^I!@*-+;:,./?"
    set.breakindent = true
    set.wrap = true
  end,
})

api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "xml" },
  callback = function()
    vim.b.autoformat = false
  end,
})

api.nvim_create_autocmd({ "LspAttach" }, {
  pattern = "*",
  desc = "Disables Treesitter highlights in LSP's that support full sematnic tokens or in files that are larger than 5mb or 10k lines",
  callback = function(ev)
    local id = ev.data.client_id
    local client = vim.lsp.get_client_by_id(id) or nil
    local buf = ev.buf
    local filename = vim.api.nvim_buf_get_name(buf)
    local has_full_semantic_tokens = client
      and client.server_capabilities.semanticTokensProvider
      and client.server_capabilities.semanticTokensProvider.full

    if filename:match("%.svelte$") then
      if vim.api.nvim_buf_line_count(buf) > 10000 or vim.fn.getfsize(filename) > 5 * 1024 * 1024 then
        vim.cmd([[TSBufDisable highlight]])
      else
        vim.cmd([[TSBufEnable highlight]])
      end
    elseif has_full_semantic_tokens then
      vim.cmd([[TSBufDisable highlight]])
    else
      if vim.api.nvim_buf_line_count(buf) > 10000 then
        vim.cmd([[TSBufDisable highlight]])
      else
        vim.cmd([[TSBufEnable highlight]])
      end
    end
  end,
})
