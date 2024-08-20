---@module "cmp"

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-cmdline",
  },
  opts = function(_, opts)
    local cmp = require("cmp")

    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Replace, select = true }),
        { "i", "c" }
      ),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Replace, select = true })),
    })

    table.insert(opts.sources, { name = "lazydev", group_index = 0 })
    table.insert(opts.sources, { name = "neorg" })

    -- opts.sources = {
    --   { {
    --       name = "nvim_lsp",
    --       entry_filter = function(entry, _)
    --         return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
    --       end,
    --     },
    --   },
    -- }

    -- cmp.setup.cmdline(cmp_utils.cmdline_search.type, cmp_utils.cmdline_search.opts)
    -- cmp.setup.cmdline(cmp_utils.cmdline.type, cmp_utils.cmdline.opts)
  end,
}
