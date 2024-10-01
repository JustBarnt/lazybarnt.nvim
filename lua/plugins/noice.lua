---@module 'noice'

return {
  "justbarnt/noice.nvim",
  dev = false,
  event = "VeryLazy",
  opts = {
    lsp = {
      hover = {
        silent = true,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    presets = {
      bottom_search = true,
      command_palette = false,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    popupmenu = {
      backend = "cmp",
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
      {
        opts = { skip = true },
        filter = {
          any = {
            {
              error = true,
              find = "E486: Pattern not found",
            },
            {
              event = "msg_show",
              cond = function(msg)
                return msg:content():sub(1, 1) == "/"
              end,
            },
          },
        },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "No information available",
        },
        opts = { skip = true },
      },
      {
        view = "split",
        filter = { event = "msg_show", min_height = 20 },
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = 5,
          col = "50%",
        },
        border = {
          style = "none",
          padding = { 1, 1 },
        },
        size = {
          width = 60,
          height = "auto",
        },
        win_options = {
          winhighlight = {
            Normal = "TelescopePromptNormal",
            FloatBorder = "TelescopePromptNormal",
          },
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 8,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "none",
          padding = { 1, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "TelescopeNormal",
            FloatBorder = "TelescopeNormal",
          },
        },
      },
    },
  },
}
