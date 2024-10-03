local M = {}

local cmp = require("cmp")
local types = require("cmp.types")
local compare = require("cmp.config.compare")
local luasnip = require("luasnip")

---Check whether `check` and call action or fallback
---@param check boolean: true -> action(), false -> fallback()
---@param action function
---@param fallback function
---@return any: result of calling action or fallback
local function call_with_fallback(check, action, fallback)
  if check then
    return action()
  else
    return fallback()
  end
end

---@type table<number, number>
local modified_priority = {
  [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
  [types.lsp.CompletionItemKind.Class] = types.lsp.CompletionItemKind.Method,
  [types.lsp.CompletionItemKind.Keyword] = 0,
  [types.lsp.CompletionItemKind.Snippet] = 0,
  [types.lsp.CompletionItemKind.Text] = 100,
}
---@param kind number
local function modified_kind(kind)
  return modified_priority[kind] or kind
end

local buffers = {
  name = "buffer",
  option = {
    keyword_length = 6,
    get_bufnrs = function() -- from all buffers (less than 1MB)
      local bufs = {}
      for _, bufn in ipairs(vim.api.nvim_list_bufs()) do
        local buf_size = vim.api.nvim_buf_get_offset(bufn, vim.api.nvim_buf_line_count(bufn))
        if buf_size < 1024 * 1024 then
          table.insert(bufs, bufn)
        end
      end
      return bufs
    end,
  },
}

M.formatting = {
  ---@param entry cmp.Entry
  ---@param item vim.CompletedItem
  format = function(entry, item)
    local icons = {
      Text = "  ",
      Method = "  ",
      Function = "  ",
      Constructor = "  ",
      Field = "  ",
      Variable = "  ",
      Class = "  ",
      Interface = "  ",
      Module = "  ",
      Property = "  ",
      Unit = "  ",
      Value = "  ",
      Enum = "  ",
      Keyword = "  ",
      Snippet = "  ",
      Color = "  ",
      File = "  ",
      Reference = "  ",
      Folder = "  ",
      EnumMember = "  ",
      Constant = "  ",
      Struct = "  ",
      Event = "  ",
      Operator = "  ",
      TypeParameter = "  ",
    }
    item.kind = string.format("%s %s", icons[item.kind], item.kind)
    return item
  end,
}

M.mapping = {
  ["<C-j>"] = cmp.mapping.select_next_item(),
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  ["<Up>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  ["<Down>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
  ["<C-e>"] = cmp.mapping.abort(),
  ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
  ["<CR>"] = cmp.mapping.confirm({ select = false }),
  ["<C-l>"] = cmp.mapping(function(fallback)
    call_with_fallback(luasnip.in_snippet() and luasnip.jumpable() or false, function()
      luasnip.jump(1)
    end, fallback)
  end, { "i", "s" }),
  ["<C-h>"] = cmp.mapping(function(fallback)
    call_with_fallback(luasnip.jumpable(-1), function()
      luasnip.jump(-1)
    end, fallback)
  end, { "i", "s" }),
}

M.sources = cmp.config.sources({
  { name = "nvim_lsp" },
  { name = "lazy_dev", group_index = 0 },
  { name = "luasnip" },
  { name = "path" },
}, {
  buffers,
})

M.snippet = {
  expand = function(args)
    luasnip.lsp_expand(args.body)
  end,
}

M.sorting = {
  comparators = {
    compare.offset,
    compare.exact,
    function(entry1, entry2) -- sort by length ignoring "=~"
      local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
      local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
      if len1 ~= len2 then
        return len1 - len2 < 0
      end
    end,
    compare.recently_used,
    function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
      local kind1 = modified_kind(entry1:get_kind())
      local kind2 = modified_kind(entry2:get_kind())
      if kind1 ~= kind2 then
        return kind1 - kind2 < 0
      end
    end,
    function(entry1, entry2) -- score by lsp, if available
      local t1 = entry1.completion_item.sortText
      local t2 = entry2.completion_item.sortText
      if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
        return t1 < t2
      end
    end,
    compare.score,
    compare.order,
  },
}

return M
