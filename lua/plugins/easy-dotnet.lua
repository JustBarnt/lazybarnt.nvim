return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    config = function()
      local function get_secret_path(secret_guid)
        local path = ""
        local home_dir = vim.fn.expand("~")
        if require("easy-dotnet.extensions").isWindows() then
          local secret_path = home_dir
            .. "\\AppData\\Roaming\\Microsoft\\UserSecrets\\"
            .. secret_guid
            .. "\\secrets.json"
          path = secret_path
        else
          local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
          path = secret_path
        end
        return path
      end

      local dotnet = require("easy-dotnet")
      dotnet.setup({
        --Optional function to return the path for the dotnet sdk (e.g C:/ProgramFiles/dotnet/sdk/8.0.0)
        -- easy-dotnet will resolve the path automatically if this argument is omitted, for a performance improvement you can add a function that returns a hardcoded string
        -- You should define this function to return a hardcoded path for a performance improvement 🚀
        get_sdk_path = "C:/Program Files/dotnet/sdk/9.0.103/",
        ---@type TestRunnerOptions
        test_runner = {
          ---@type "split" | "float" | "buf"
          viewmode = "float",
          enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
          noBuild = true,
          noRestore = true,
          icons = {
            passed = "",
            skipped = "",
            failed = "",
            success = "",
            reload = "",
            test = "",
            sln = "󰘐",
            project = "󰘐",
            dir = "",
            package = "",
          },
          -- mappings = {
          --   jun_test_from_buffer = { lhs = "<leader>rt", desc = "run test from buffer" },
          --   debug_test = { lhs = "<leader>d", desc = "debug test" },
          --   go_to_file = { lhs = "g", desc = "got to file" },
          --   run_all = { lhs = "<leader>R", desc = "run all tests" },
          --   run = { lhs = "<leader>r", desc = "run test" },
          --   peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
          --   expand = { lhs = "o", desc = "expand" },
          --   expand_node = { lhs = "E", desc = "expand node" },
          --   expand_all = { lhs = "-", desc = "expand all" },
          --   collapse_all = { lhs = "W", desc = "collapse all" },
          --   close = { lhs = "q", desc = "close testrunner" },
          --   refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" }
          -- },
          --- Optional table of extra args e.g "--blame crash"
          -- additional_args = {},
        },
        ---@param action "test" | "restore" | "build" | "run"
        terminal = function(path, action, args)
          local commands = {
            run = function()
              return string.format("dotnet run --project %s %s", path, args)
            end,
            test = function()
              return string.format("dotnet test %s %s", path, args)
            end,
            restore = function()
              return string.format("dotnet restore %s %s", path, args)
            end,
            build = function()
              return string.format("dotnet build %s %s", path, args)
            end,
          }

          local command = commands[action]() .. "\r"
          vim.cmd("vsplit")
          vim.cmd("term " .. command)
        end,
        secrets = {
          path = get_secret_path,
        },
        csproj_mappings = true,
        fsproj_mappings = true,
        auto_bootstrap_namespace = {
          --block_scoped, file_scoped
          type = "file_scoped",
          enabled = true,
        },
        -- choose which picker to use with the plugin
        -- possible values are "telescope" | "fzf" | "basic"
        picker = "fzf",
      })
    end,
  },
}
