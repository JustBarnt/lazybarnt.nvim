---@module 'fastaction'
return {
  {
    "Chaitanyabsprip/fastaction.nvim",
    ---@type FastActionConfig
    opts = {},
    event = "LspAttach",
    config = function(_, opts)
      require("fastaction").setup(opts)

      local keys = require("justvi.plugins.lsp.keymaps").get()
      keys[#keys + 1] =
      { "<leader>ca", "<CMD>FastAction<CR>", desc = "FastAction: Cursor", mode = { "n" }, has = "codeAction" }
      keys[#keys + 1] =
      { "<leader>cA", "<CMD>FastActionRange<CR>", desc = "FastAction: Range", mode = { "v" }, has = "codeAction" }
    end,
  },
}
