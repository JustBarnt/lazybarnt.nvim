return {
  "saghen/blink.cmp",
  lazy = false,
  dev = true,
  build = "cargo build --release",
  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    sources = {
      providers = {
        { "blink.cmp.sources.lsp", name = "LSP" },
        { "blink.cmp.sources.snippets", name = "Snippets", score_offset = -1 },
        {
          "blink.cmp.sources.path",
          name = "Path",
          score_offset = 3,
          opts = { get_cwd = vim.uv.cwd },
        },
        {
          "blink.cmp.sources.buffer",
          name = "Buffer",
          keyword_length = 3,
          fallback_for = { "LSP" }, -- PENDING https://github.com/Saghen/blink.cmp/issues/122
        },
      },
    },
    trigger = {
      signature_help = {
        enabled = true,
      },
    },
    highlight = { use_nvim_cmp_as_default = true },
    fuzzy = {
      prebuiltBinaries = {
        download = false,
        forceVersion = "v0.3.*",
      },
    },
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
        selection = "auto_insert",
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
