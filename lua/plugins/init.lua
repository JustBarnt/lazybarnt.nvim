return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    tag = "v4.4.7",
    opts = {
      popupmenu = {
        enabled = false,
      },
      lsp = {
        hover = {
          silent = true,
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
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
}
