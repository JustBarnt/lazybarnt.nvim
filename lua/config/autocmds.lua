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
  desc = "Changes folding methods based on if the LSP Supports it",
  callback = function(ev)
    local id = ev.data.client_id
    local client = vim.lsp.get_client_by_id(id) or nil
    local buf = ev.buf

    if client and client:supports_method("textDocument/foldingRange", buf) then
      vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
    end

    --- @param client vim.lsp.Client the LSP client
    local function monkey_patch_semantic_tokens(client)
      -- NOTE: Super hacky... Don't know if I like that we set a random variable on
      -- the client Seems to work though ~seblj
      if client.is_hacked then
        return
      end
      client.is_hacked = true

      -- let the runtime know the server can do semanticTokens/full now
      client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities, {
        semanticTokensProvider = {
          full = true,
        },
      })

      -- monkey patch the request proxy
      local request_inner = client.request
      function client:request(method, params, handler, req_bufnr)
        if method ~= vim.lsp.protocol.Methods.textDocument_semanticTokens_full then
          return request_inner(self, method, params, handler)
        end

        local target_bufnr = vim.uri_to_bufnr(params.textDocument.uri)
        local line_count = vim.api.nvim_buf_line_count(target_bufnr)
        local last_line = vim.api.nvim_buf_get_lines(target_bufnr, line_count - 1, line_count, true)[1]

        return request_inner(self, "textDocument/semanticTokens/range", {
          textDocument = params.textDocument,
          range = {
            ["start"] = {
              line = 0,
              character = 0,
            },
            ["end"] = {
              line = line_count - 1,
              character = string.len(last_line) - 1,
            },
          },
        }, handler, req_bufnr)
      end
    end

    if client and client.name == "roslyn" then
      monkey_patch_semantic_tokens(client)
    end
  end,
})

api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    local clients = vim.lsp.get_clients({ name = "roslyn" })
    if not clients or #clients == 0 then
      return
    end

    local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
    for _, buf in ipairs(buffers) do
      vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
    end
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
