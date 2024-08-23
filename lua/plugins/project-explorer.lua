return {
  dev = true,
  "justbarnt/project-explorer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = function(_, opts)
    ---@param directories string[]
    ---@return string[] dirs
    local project_paths = function(directories)
      local path_exists = vim.fn.isdirectory(directory)
      local valid_paths = {}

      for _, dir in ipairs(directories) do
        if vim.fn.isdirectory(dir) == 1 then
          table.insert(valid_paths, dir)
        end
      end

      return valid_paths
    end

    return {
      paths = { "D:/Commsys", "D:/Github", "D:/nvim-plugins" }, --project_paths({ "D:/Commsys", "D:/Github", "D:/nvim-plugins" }),
      command_pattern = "fd . %s -td -H -E '.git' --min-depth %d --max-depth %d",
      newProjectPath = "d:/github", --{ "d:/github/", "d:/nvim/" },
      file_explorer = function(dir) --custom file explorer set by user
        vim.cmd("Neotree close")
        vim.cmd("Neotree " .. dir)
      end,
    }
  end,
  config = function(_, opts)
    require("project_explorer").setup(opts)
  end,
  keys = {
    { "<leader>fp", "<CMD>ProjectExplorer<CR>", desc = "Find Projects" },
  },
  lazy = false,
}
