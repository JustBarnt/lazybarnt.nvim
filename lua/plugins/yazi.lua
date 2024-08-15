---@type LazySpec
return {
  {
    "mikavilpas/yazi.nvim",
    enabled = vim.g.neovide,
    event = "VeryLazy",
    keys = {
      {
        "-",
        "<CMD>Yazi cwd<CR>",
        desc = "Open Yazi in Current Working Directory",
      },
      {
        "<leader>-",
        "<CMD>Yazi<CR>",
        desc = "Open Yazi at current file",
      },
    },
    ---@type YaziConfig
    opts = {
      open_for_directories = false,
      use_ya_for_events_reading = true,
      use_yazi_client_id_flag = true,
    },
  },
}
