return {
  {
    "neovim/nvim-lspconfig",
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
        tailwindcss = {
          root_dir = require("lspconfig.util").root_pattern(
            "tailwind.config.js",
            "tailwind.config.cjs",
            "tailwind.config.mjs",
            "tailwind.config.ts",
            "postcss.config.js",
            "postcss.config.cjs",
            "postcss.config.mjs",
            "postcss.config.ts",
            "package.json",
            "node_modules"
          ),
        },
      },
    },
  },
}
