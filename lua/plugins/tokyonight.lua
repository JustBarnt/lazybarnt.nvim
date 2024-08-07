return {
  "folke/tokyonight.nvim",
  priority = 1000,
  lazy = false,
  opts = function()
    return {
      styles = {
        functions = { bold = true },
        keywords = { bold = true },
      },
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
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
}
