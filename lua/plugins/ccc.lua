return {
  {
    "uga-rosa/ccc.nvim",
    event = "FileType",
    keys = {
      { "<Leader>uP", "<cmd>CccPick<CR>", desc = "Color-picker" },
    },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
        filetypes = {
          "html",
          "lua",
          "css",
          "scss",
          "sass",
          "less",
          "stylus",
          "javascript",
          "tmux",
          "typescript",
        },
        excludes = { "lazy", "mason", "help", "neo-tree" },
      },
    },
  },
}
