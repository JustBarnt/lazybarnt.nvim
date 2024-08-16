return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      ---@module "eldritch"
      return {
        transparent = true,
        styles = {
          functions = { bold = true },
          keywords = { bold = true },
        },
        ---@param hl Highlights
        ---@param c ColorScheme
        on_highlights = function(hl, c)
          -- Telescope
          local prompt = "#323449"
          hl.TelescopePromptNormal = {
            bg = prompt,
          }
          hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePromptTitle = {
            bg = prompt,
            fg = c.fg,
          }
          hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }

          hl.TelescopePreview = {
            bg = prompt,
            fg = c.fg,
          }
          hl.TelescopePreviewNormal = {
            bg = prompt,
            fg = c.fg,
          }
          hl.TelescopePreviewTitle = {
            bg = prompt,
            fg = c.fg,
          }
          hl.TelescopePreviewBorder = {
            bg = prompt,
            fg = prompt,
          }

          hl.TelescopeResults = {
            bg = c.bg_dark,
            fg = c.fg,
          }
          hl.TelescopeResultsNormal = {
            bg = c.bg_dark,
            fg = c.fg,
          }
          hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.fg,
          }
          hl.TelescopeResultsBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopeMatching = {
            fg = c.purple,
          }
        end,
      }
    end,
  },
}
