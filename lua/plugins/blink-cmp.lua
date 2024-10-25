return {
  "saghen/blink.cmp",
  enabled = true,
  version = "v0.4.*",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    highlight = { use_nvim_cmp_as_default = true },
    keymap = {
      show = "<C-space>",
      hide = "<C-e>",
      accept = "<C-y>",
      select_prev = { "<C-k>" },
      select_next = { "<C-j>" },
      show_documentation = "<C-space>",
      hide_documentation = "<C-space>",
      scroll_documentation_up = "<Up>",
      scroll_documentation_down = "<Down>",

      snippet_forward = "<Tab>",
      snippet_backward = "<S-Tab>",
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
