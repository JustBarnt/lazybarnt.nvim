return {
  {
    "neovim/nvim-lspconfig",
    ---@param opts lspconfig.options
    opts = function(_, opts)
      ---@type lspconfig.options.tailwindcss
      ---@diagnostic disable
      local tailwindcss = {
        root_dir = require("lspconfig.util").root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs",
          "postcss.config.mjs",
          "postcss.config.ts"
        ),
      }

      opts.servers.tailwindcss = tailwindcss
    end,
  },
}
