return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = function(_, opts)
      vim.list_extend(opts.library, {
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "luafilesystem", words = { "lfs%." } },
      })
    end,
  },
}
