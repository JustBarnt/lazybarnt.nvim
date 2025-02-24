---@diagnostic disable: missing-fields
return {
  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lua = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
              },
            },
          },
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      table.insert(opts.linters_by_ft, { lua = { "selene", "luacheck" } })
      table.insert(opts.linters, {
        selene = {
          condition = function(ctx)
            local root = JustVi.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            local root = JustVi.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
          end,
        },
      })
      return opts
    end,
  },
}
