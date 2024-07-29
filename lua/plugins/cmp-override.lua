return {
  "justbarnt/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "saadparwaiz1/cmp_luasnip",
    "roobert/tailwindcss-colorizer-cmp.nvim",
    {
      "garymjr/nvim-snippets",
      config = true,
      opts = {
        friendly_snippets = true,
      },
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
  },
  opts = function()
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()

    local M = {
      defaults = {
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
          },
          completeopt = "menu,menuone,noselect,popup",
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
          end,
        },
        mapping = {
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
        },
        sources = cmp.config.sources({
          { name = "lazydev", group_index = 0 },
          {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
              return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
            end,
          },
          { name = "snippets" },
        }, {
          { name = "path" },
          { name = "buffer", keyword_length = 5, max_item_count = 4 },
        }),
        sorting = defaults.sorting,
        window = {
          completion = {
            border = "solid",
            winhighlight = "Normal:TelescopePromptNormal,FloatBorder:TelescopePromptNormal,Search:None",
            col_offset = -4,
            side_padding = 0,
          },
          documentation = {
            border = "solid",
            winhighlight = "Normal:TelescopePromptNormal,FloatBorder:TelescopePromptNormal,Search:None",
          },
        },
      },
      search = {
        experimental = {
          ghost_text = false,
        },
        ---@diagnostic disable: missing-fields
        formatting = {
          fields = { "abbr" },
        },
        sources = {
          { name = "buffer" },
        },
        view = {
          entries = {
            name = "wildmenu",
            separator = " | ",
          },
        },
        window = {
          completion = {
            border = "Solid", -- single|rounded|none
            winhighlight = "Normal:TelescopeNormal,FloatBorder:TelescopeNormal,Search:None",
            winblend = 0,
            col_offset = -4,
          },
        },
      },
      cmdline = {
        formatting = { fields = { "abbr" } },
        mapping = cmp.mapping.preset.cmdline({
          ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Replace }), { "c" }),
          ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Replace }), { "c" }),
        }),
        sources = {
          { name = "cmdline" },
          { name = "path" },
        },
        window = {
          completion = {
            border = "solid",
            winhighlight = "Normal:TelescopeNormal,FloatBorder:TelescopeNormal,Search:None",
            col_offset = -4,
            side_padding = 4,
            width = 60,
            row = 7,
            col = (vim.o.columns - 62) / 2,
          },
        },
        view = {
          entries = {
            name = "custom",
            follow_cursor = false,
            selection_order = "near_cursor",
          },
        },
      },
    }

    return M
  end,
  ---@param opts {default: cmp.ConfigSchema, search: cmp.ConfigSchema, cmdline: cmp.ConfigSchema}
  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts.default)
    cmp.setup.cmdline({ "/", "?" }, opts.search)
    cmp.setup.cmdline({ ":" }, opts.cmdline)
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  end,
}
