local noice_cfg = require("utils.noice")

---@module 'noice'
return {
  "folke/noice.nvim",
  event = "UIEnter",
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "noice",
      callback = function(ctx)
        noice_cfg.highlights_in_stacktrace(ctx.buf)
      end,
    })
  end,
  keys = noice_cfg.keys,
  ---@type fun(_, opts: NoiceConfig): NoiceConfig
  opts = function(_, opts)
    ---@type NoiceConfig
    local ret = {
      lsp = noice_cfg.lsp,
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
      popupmenu = {
        backend = "cmp",
      },
      routes = noice_cfg.routes,
      views = noice_cfg.views,
      commands = noice_cfg.commands,
      notify = { merge = true },
    }
    return ret
  end,
}
