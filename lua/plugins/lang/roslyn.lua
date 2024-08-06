return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "c_sharp")
    end,
  },
  {
    { "seblj/roslyn.nvim", opts = { filewatching = false } },
  },
}
