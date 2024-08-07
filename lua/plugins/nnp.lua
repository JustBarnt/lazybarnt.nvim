---@module 'no-neck-pain'
return {
  {
    "shortcuts/no-neck-pain.nvim",
    opts = {
      killAllBuffersOnDisable = true,
      mappings = {
        enabled = true,
      },
      buffers = {
        left = {
          enabled = true,
          scratchPad = {
            enabled = true,
            pathToFile = "~/.neorg/Work/todo.norg",
          },
          bo = {
            filetype = "norg",
          },
        },
        right = {
          enabled = true,
          scratchPad = {
            enabled = true,
            pathToFile = "~/.neorg/scratchPad.md",
          },
          bo = {
            filetype = "md",
          },
        },
      },
    },
    -- config = function(_, opts)
    --   require("no-neck-pain").setup(opts)
    -- end,
  },
}
