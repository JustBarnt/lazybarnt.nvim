---@module "cmp"

return {
  {
    "justbarnt/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")

      -- cmp.setup(opts)
      cmp.setup.cmdline({ "/", "?" }, {
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
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
}
