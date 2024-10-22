local M = {}

M.keys = {
  { "<Esc>", vim.cmd.NoiceDismiss, desc = "󰎟 Clear Notifications" },
}

---@param bufnr number
M.highlights_in_stacktrace = function(bufnr)
  vim.defer_fn(function()
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    vim.api.nvim_buf_call(bufnr, function()
      vim.fn.matchadd("WarningMsg", [[[^/]\+\.lua:\d\+\ze:]]) -- files with error
      vim.fn.matchadd("WarningMsg", [[E\d\+]]) -- vim error codes
    end)
  end, 1)
end

---@type table<string, NoiceCommand>
M.commands = {
  history = {
    filter_opts = { reverse = true },
    opts = {
      format = { "{title} ", "{message}" },
      filter = { ["not"] = { find = "^/" } }, -- skip search messages
    },
  },
  ---@diagnostic disable-next-line: missing-fields
  last = {
    opts = { format = { "{title} ", "{message}" } },
    filter = { ["not"] = { find = "^/" } }, -- skip search messages
  },
  ---@diagnostic disable-next-line: missing-fields
  errors = {
    opts = { format = { "{title} ", "{message}" } },
  },
}

---@type NoiceRouteConfig[]
M.routes = {
  -- output from `:Inspect`, for easier copying
  { filter = { event = "msg_show", find = "Treesitter.*- @" }, view = "popup" },

  -----------------------------------------------------------------------------
  -- REDIRECT TO MINI

  -- write/deletion messages
  { filter = { event = "msg_show", find = "%d+B written$" }, view = "mini" },
  { filter = { event = "msg_show", find = "%d+L, %d+B$" }, view = "mini" },
  { filter = { event = "msg_show", find = "%-%-No lines in buffer%-%-" }, view = "mini" },

  -- search
  { filter = { event = "msg_show", find = "^E486: Pattern not found" }, view = "mini" },

  -- word added to spellfile via `zg`
  { filter = { event = "msg_show", find = "^Word .*%.add$" }, view = "mini" },

  -- gitsigns.nvim
  { filter = { event = "msg_show", find = "Hunk %d+ of %d+" }, view = "mini" },
  { filter = { event = "msg_show", find = "No hunks" }, view = "mini" },

  -- :LspRestart
  { filter = { event = "notify", find = "Restarting…" }, view = "mini" },

  -- nvim-treesitter
  { filter = { event = "msg_show", find = "^%[nvim%-treesitter%]" }, view = "mini" },
  { filter = { event = "notify", find = "All parsers are up%-to%-date" }, view = "mini" },

  -----------------------------------------------------------------------------
  -- SKIP

  -- FIX LSP bugs?
  { filter = { event = "msg_show", find = "lsp_signature? handler RPC" }, skip = true },
	-- stylua: ignore
	{ filter = { event = "msg_show", find = "^%s*at process.processTicksAndRejections" }, skip = true },

  -- code actions
  { filter = { event = "notify", find = "No code actions available" }, skip = true },

  -- unneeded info on search patterns when pattern not found
  { filter = { event = "msg_show", find = "^[/?]." }, skip = true },

  -- useless notification when closing buffers
  {
    filter = { event = "notify", find = "^Client marksman quit with exit code 1 and signal 0." },
    skip = true,
  },
  {
    view = "split",
    filter = { event = "msg_show", min_height = 20 },
  },
}

M.lsp = {
  progress = { enabled = false },
  signature = {
    enabled = false,
  },
  hover = {
    silent = true,
  },
  override = {
    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    ["vim.lsp.util.stylize_markdown"] = true,
  },
}

---@type NoiceConfigViews
M.views = {
  cmdline_popup = {
    position = {
      row = 5,
      col = "50%",
    },
    border = {
      style = "none",
      padding = { 1, 1 },
    },
    size = {
      width = 60,
      height = "auto",
    },
    win_options = {
      winhighlight = {
        Normal = "TelescopePromptNormal",
        FloatBorder = "BlinkCmpMenuBorder",
      },
    },
  },
  hover = {
    border = {
      style = "rounded",
      padding = { 0, 2 },
    },
    size = { max_width = 80 },
    win_options = {
      scrolloff = 4,
      wrap = true,
      winhighlight = {
        Normal = "Pmenu",
        CursorLine = "PmenuSel",
        FloatBorder = "BlinkCmpMenuBorder",
      },
    },
  },
  mini = { timeout = 3000, zindex = 45, format = { "{title} ", "{message}" } },
  popupmenu = {
    relative = "editor",
    position = {
      row = 8,
      col = "50%",
    },
    size = {
      width = 60,
      height = 10,
    },
    border = {
      style = "single",
      padding = { 1, 1 },
    },
    win_options = {
      winhighlight = {
        Normal = "TelescopePromptNormal",
        FloatBorder = "CmpBorder",
      },
    },
  },
}

return M
