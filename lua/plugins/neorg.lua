return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    build = function()
      vim.opt.shell = "cmd.exe"
      vim.cmd([[Neorg sync-parsers]])
      vim.opt.shell = "nu"
    end,
    version = "*",
    config = function()
      require("neorg").setup()
    end,
  },
}
