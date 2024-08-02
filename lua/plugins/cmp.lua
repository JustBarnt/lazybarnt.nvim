---@module "cmp"
return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, { name = "neorg" })
  end,
}
