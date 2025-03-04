return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    build = "cargo build --release",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      fuzzy = {
        implementation = "prefer_rust",
      },
      keymap = {
        preset = "default",
        ["Up"] = { "scroll_documentation_up", "fallback" },
        ["Down"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        ghost_text = { enabled = true },
        list = {
          selection = {
            auto_insert = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
          },
        },
        menu = {
          enabled = true,
          cmdline_position = function()
            if vim.g.ui_cmdline_pos ~= nil then
              local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
              return { pos[1] - 1, pos[2] }
            end
            local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
            return { vim.o.lines - height, 0 }
          end,
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          update_delay_ms = 50,
          treesitter_highlighting = true,
        },
      },
      cmdline = {
        enabled = true,
        keymap = {
          ["<CR>"] = { "accept_and_enter", "fallback" },
        },
        ---@diagnostic disable-next-line: assign-type-mismatch
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = false },
          trigger = {
            show_on_blocked_trigger_characters = {},
            show_on_x_blocked_trigger_characters = nil,
          },
        },
      },
      sources = {
        default = function()
          local success, node = pcall(vim.treesitter.get_node)
          if vim.bo.filetype == "lua" then
            return { "lsp", "path" }
          elseif vim.bo.filetype == "cs" then
            return { "lsp", "path", "easy-dotnet" }
          elseif success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            return { "buffer" }
          else
            return { "lsp", "path", "snippets", "buffer", "lazydev" }
          end
        end,
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          ["easy-dotnet"] = {
            name = "easy-dotnet",
            enabled = true,
            module = "easy-dotnet.completion.blink",
            score_offset = 10000,
            async = true,
          },
        },
      },

      appearance = {
        highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",

          Field = "󰜢",
          Variable = "󰆦",
          Property = "󰖷",

          Class = "󱡠",
          Interface = "󱡠",
          Struct = "󱡠",
          Module = "󰅩",

          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰦨",
          EnumMember = "󰦨",

          Keyword = "󰻾",
          Constant = "󰏿",

          Snippet = "󱄽",
          Color = "󰏘",
          File = "󰈔",
          Reference = "󰬲",
          Folder = "󰉋",
          Event = "󱐋",
          Operator = "󰪚",
          TypeParameter = "󰬛",
        },
      },
    },
  },
}
