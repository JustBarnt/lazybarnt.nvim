---@module "cmp"

return {
  {
    "justbarnt/nvim-cmp",
    event = "InsertEnter",
    dev = false,
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function(_, opts)
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local auto_select = true

      local filter_text = function(entry, _)
        return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
      end

      return {
        auto_brackets = {},
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        experimental = {
          ghost_text = {
            enabled = false,
            hl_group = "CmpGhostText",
          },
        },
        formatting = {
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
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<S-j>"] = cmp.mapping.scroll_docs(-4),
          ["<S-k>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping.complete({}),
        }),
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "lazydev", group_index = 0 },
        }, {
          { name = "path", option = { keyword_pattern = "[[/|\\]]" } },
          { name = "buffer", option = { keyword_lenth = 4, max_item_count = 4 } },
        }),
        sorting = defaults.sorting,
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)
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

      --HACK: Maybe hack? Not sure. But this will allow the menu to shift over to the left by resetting the 'col' property the menu
      --      uses to the position itself.
      --TODO: Move this autocmd into `nvim-cmp` as I believe it belongs there
      vim.api.nvim_create_autocmd("CmdlineEnter", {
        group = vim.api.nvim_create_augroup("cmdlime_menu", { clear = true }),
        callback = function(_)
          local old_values = require("cmp.config").cmdline[":"].window.completion or {}
          local config = require("cmp.config").cmdline[":"]

          ---@type cmp.CompletionWindowOptions
          local new_values = vim.tbl_deep_extend("force", old_values, {
            col = (vim.o.columns - 62) / 2,
          })

          config.window.completion = new_values

          -- Re-setup the cmdline to apply the new col values
          require("cmp").setup.cmdline({ ":" }, config)
        end,
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
        window = {
          completion = {
            border = "solid",
            winhighlight = "Normal:TelescopeNormal,FloatBorder:TelescopeNormal,Search:None",
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
      })
    end,
  },
  -- Snippets
  {
    "nvim-cmp",
    dependencies = {
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
        },
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(item)
          return LazyVim.cmp.expand(item.body)
        end,
      }
      if LazyVim.has("nvim-snippets") then
        table.insert(opts.sources, { name = "snippets" })
      end
    end,
  },
  -- Tailwindcss
  {
    "nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item)
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
}
