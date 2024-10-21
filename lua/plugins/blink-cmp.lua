return {
  "saghen/blink.cmp",
  event = "BufReadPre",
  enabled = false,
  version = "v0.3.1", -- REQUIRED release tag to download pre-built binaries
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
    highlight = { use_nvim_cmp_as_default = true },
    keymap = {
      show = "<C-space>",
      hide = "<C-e>",
      accept = "<C-y>",
      select_prev = { "<C-j>" },
      select_next = { "<C-k>" },

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
        border = "none",
        highlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
        selection = "preselect",
        draw = "reversed",
        cycle = { from_top = false },
      },
      documentation = {
        border = "none",
        winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
        auto_show = true,
        auto_show_delay_ms = 250,
      },
    },
  },
}
