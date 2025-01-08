return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "c_sharp")
    end,
  },
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = function(_, opts)
      local blink = require("blink.cmp")
      local config = {
        config = {
          capabilities = vim.tbl_deep_extend(
            "force",
            require("lang.lsp.csharp_capabilities"),
            vim.lsp.protocol.make_client_capabilities(),
            blink.get_lsp_capabilities(),
            opts.capabiltites or {}
          ),
        },
        filewatching = true,
      }
      return config
    end,
  },
}
