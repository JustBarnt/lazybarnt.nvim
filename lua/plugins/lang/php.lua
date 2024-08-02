return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "php")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@param opts lspconfig.options
    opts = function(_, opts)
      ---@diagnostic disable
      ---@type lspconfig.options.intelephense
      local intelephense = {
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
      }

      opts.servers.intelephense = intelephense
    end,
  },
}
