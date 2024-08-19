return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = function(_, opts)
      vim.list_extend(opts.library, {
        { path = "wezterm-types", mods = { "wezterm" } },
      })
    end,
  },
}
