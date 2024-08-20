return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
      require("markview").setup({
        modes = { "n", "no", "i", "c" },
        hybrid_modes = { "i" },
        callbacks = {
          on_enable = function(_, win)
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = "nc"
            vim.wo[win].wrap = false
          end,
          on_disable = function(_, win)
            vim.wo[win].wrap = false
          end,
        },
        highlight_groups = {
          {
            group_name = "Heading1",
            value = { fg = "#1e1e2e", bg = "#a6e3a1" },
          },
          {
            group_name = "Heading1Corner",
            value = { fg = "#a6e3a1" },
          },
        },
        links = {
          inline_links = {
            hl = "@markup.link.label.markown_inline",
            icon = " ",
            icon_hl = "@markup.link",
          },
          images = {
            hl = "@markup.link.label.markown_inline",
            icon = " ",
            icon_hl = "@markup.link",
          },
        },
        code_blocks = {
          style = "minimal",
          icons = true,
        },
        list_items = {
          shift_width = 2,
          marker_minus = { text = "●", hl = "@markup.list.markdown" },
          marker_plus = { text = "●", hl = "@markup.list.markdown" },
          marker_star = { text = "●", hl = "@markup.list.markdown" },
          marker_dot = {},
        },
        inline_codes = { enable = false },
        headings = {
          heading_1 = { style = "simple", hl = "Headline1" },
          heading_2 = { style = "simple", hl = "Headline2" },
          heading_3 = { style = "simple", hl = "Headline3" },
          heading_4 = { style = "simple", hl = "Headline4" },
          heading_5 = { style = "simple", hl = "Headline5" },
          heading_6 = { style = "simple", hl = "Headline6" },
        },
        horizontal_rules = {
          parts = {
            {
              type = "repeating",
              text = "─",

              direction = "left",
              hl = {
                "Gradient1",
                "Gradient2",
                "Gradient3",
                "Gradient4",
                "Gradient5",
                "Gradient6",
                "Gradient7",
                "Gradient8",
                "Gradient9",
                "Gradient10",
              },

              repeat_amount = function()
                local w = vim.api.nvim_win_get_width(0)
                local l = vim.api.nvim_buf_line_count(0)

                l = vim.fn.strchars(tostring(l)) + 4

                return math.floor((w - (l + 3)) / 2)
              end,
            },
            {
              type = "text",
              text = "  ",
            },
            {
              type = "repeating",
              text = "─",

              direction = "right",
              hl = {
                "Gradient1",
                "Gradient2",
                "Gradient3",
                "Gradient4",
                "Gradient5",
                "Gradient6",
                "Gradient7",
                "Gradient8",
                "Gradient9",
                "Gradient10",
              },

              repeat_amount = function()
                local w = vim.api.nvim_win_get_width(0)
                local l = vim.api.nvim_buf_line_count(0)

                l = vim.fn.strchars(tostring(l)) + 4

                return math.ceil((w - (l + 3)) / 2)
              end,
            },
          },
        },
      })

      vim.cmd("Markview enableAll")
    end,
  },
}
