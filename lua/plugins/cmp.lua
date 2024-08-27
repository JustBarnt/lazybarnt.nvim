---@module "cmp"

return {
  "yioneko/nvim-cmp",
  branch = "perf",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "garymjr/nvim-snippets",
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },
  opts = function(_, opts)
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local format_kinds = opts.formatting.format
    local auto_select = true

    local filter_text = function(entry, _)
      return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
    end

    opts.completion = {
      completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
    }

    opts.experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    }

    opts.formatting = {
      format = function(entry, item)
        local icons = LazyVim.config.icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end

        local widths = {
          abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
          menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
        }

        for key, width in pairs(widths) do
          if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
            item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
          end
        end

        return item
      end,
    }

    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<S-j>"] = cmp.mapping.scroll_docs(-4),
      ["<S-k>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping.complete({}),
    })

    opts.preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None

    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", entry_filter = filter_text },
      { name = "lazydev", group_index = 0 },
      { name = "path", option = { keyword_pattern = "[[/|\\]]" } },
    }, {
      { name = "buffer", option = { keyword_lenth = 4 } },
    })

    opts.sorting = defaults.sorting

    opts.formatting.format = function(entry, item)
      format_kinds(entry, item) -- add icons
      return require("tailwindcss-colorizer-cmp").formatter(entry, item)
    end

    cmp.setup.cmdline({ "/", "?" }, {
      sources = cmp.config.sources({
        { name = "buffer" },
      }),
      view = {
        entries = {
          name = "wildmenu",
          separator = " | ",
        },
      },
    })

    cmp.setup.cmdline({ ":" }, {
      mapping = require("cmp").mapping.preset.cmdline({
        ["<C-j>"] = require("cmp").mapping(
          require("cmp").mapping.select_next_item({ behavior = require("cmp").SelectBehavior.Replace }),
          { "c" }
        ),
        ["<C-k>"] = require("cmp").mapping(
          require("cmp").mapping.select_prev_item({ behavior = require("cmp").SelectBehavior.Replace }),
          { "c" }
        ),
      }),
      sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "path" },
      }),
      view = {
        entries = {
          name = "custom",
        },
      },
    })
  end,
  main = "lazyvim.util.cmp",
}
