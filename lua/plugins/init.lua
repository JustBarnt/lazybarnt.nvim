return {
  {
    "mfussenegger/nvim-lint",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    tag = "v4.4.7",
    opts = {
      lsp = {
        hover = {
          silent = true,
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
