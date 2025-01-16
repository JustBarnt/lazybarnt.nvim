return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "goimports", "gofumpt" } },
    config = function()
      require("mason").setup({
        registries = { "github:mason-org/mason-registry", "github:crashdummyy/mason-registry" },
      })
    end,
  },
}
