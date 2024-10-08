return {
  { "indent-blankline.nvim", enabled = false },
  {
    "shellRaining/hlchunk.nvim",
    event = { "CursorHold", "CursorHoldI" },
    opts = {
      chunk = {
        enable = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "",
        },
        style = {
          vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("@keyword")), "fg", "gui"),
        },
      },
      indent = {
        enable = false,
        chars = {
          "│",
        },
        style = {
          vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
        },
      },
      line_num = {
        enable = false,
      },
      blank = {
        enable = false,
      },
    },
  },
}
