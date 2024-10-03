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
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local config = {
        config = {
          capabilities = vim.tbl_deep_extend(
            "force",
            require("lang.lsp.csharp_capabilities"),
            vim.lsp.protocol.make_client_capabilities(),
            has_cmp and cmp_nvim_lsp.default_capabilities() or {},
            opts.capabiltites or {}
          ),
        },
        filewatching = true,
      }
      return config
    end,
  },
}
