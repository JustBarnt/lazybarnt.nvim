return {
  "saghen/blink.cmp",
  enabled = true,
  version = "*",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    highlight = { use_nvim_cmp_as_default = true },
    keymap = {
      preset = "default",
      ["<C-j>"] = { "select_next", "accept" },
      ["<C-k>"] = { "select_prev", "accept" },
      ["Up"] = { "scroll_documentation_up" },
      ["Down"] = { "scroll_documentation_down" },
    },
    nerd_font_variant = "mono",
    windows = {
      autocomplete = {
        border = "rounded",
        highlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:None,FloatBorder:Pmenu",
        selection = "preselect",
        draw = "reversed",
      },
      documentation = {
        border = "rounded",
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
        auto_show = true,
        auto_show_delay_ms = 250,
      },
      signature_help = {
        border = "padded",
        winhighlight = "Normal:NormalFloat,CursorLine:PmenuSel,Search:None,FloatBorder:Pmenu",
      },
    },
  },
}
