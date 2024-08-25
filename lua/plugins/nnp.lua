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
        left = { enabled = false },
        right = {
          enabled = true,
          scratchPad = {
            enabled = true,
            pathToFile = "~/AppData/Local/Temp/thoughts.md",
          },
          bo = {
            filetype = "md",
          },
        },
      },
    },
  },
}
