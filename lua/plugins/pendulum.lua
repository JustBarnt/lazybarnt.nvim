return {
  {
    "ptdewey/pendulum-nvim",
    enabled = true,
    opts = {
      log_file = vim.fn.expand("~/.pendulum/time_log.csv"),
      timeout_len = 300,
      timer_len = 60,
      top_n = 10,
    },
  },
}
