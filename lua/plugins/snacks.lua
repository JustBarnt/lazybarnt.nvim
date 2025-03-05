return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      enabled = true,
      size = 1.5 * 1024 * 1024,
      line_length = 1500,
    },
    dashboard = { enabled = true },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    notify = { enabled = true },
    picker = {
      ---@class snacks.picker.matcher.Config
      matcher = {
        frecency = true,
      },
      ---@class snacks.picker.formatters.Config
      formatters = {
        file = {
          filename_first = true,
        },
      },
      actions = {
        flash = require("plugins.extras.picker").flash_on_picker,
      },
      win = {
        input = {
          keys = {
            ["<a-s>"] = { "flash", mode = { "n", "i" } },
            ["s"] = { "flash" },
          },
        },
      },
    },
    profiler = { enabled = true },
    quickfile = { enabled = true },
    scratch = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
  },
  keys = {
    {
      "<leader>fs",
      function()
        Snacks.picker.lsp_symbols({ layout = "vscode", preview = "main" })
      end,
      desc = "Symbols Finder (Snacks)",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer({ cwd = LazyVim.root(), exclude = { ".bin/**", "bin/**", "obj/**" } })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>E",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
  },
}
