return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      ---@diagnostic disable
      servers = {
        ---@diagnostic disable
        intelephense = {
          filetypes = { "php", "ctp" },
          settings = {
            intelephense = {
              environment = {
                includePaths = {
                  "C:\\PHP\\includes",
                },
              },
            },
          },
        },
      },
    },
  },
}
