local M = {}

---@param pattern string
---@return string, number
M.escape_pattern = function(pattern)
  local special_chars = "[]\\.*$^+()?{}|="
  return pattern:gsub("[" .. special_chars .. "]", "\\%1")
end

M.replace_word_instance_under_cursor = function()
  local cpos = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
  local word = vim.fn.expand("<cword>")
  local prompt = "Replace: %s Length:[%d]:"
  vim.ui.input({ prompt = string.format(prompt, word, #word) }, function(input)
    local cmd = "%%s#%s#%s#g"
    if input and #input > 0 then
      vim.cmd(string.format(cmd, word, input))
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), cpos)
    end
  end)
end

M.replace_word_under_cursor = function()
  -- local cpos = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
  -- local word = vim.fn.expand("<cword>")
  -- local ns_id = vim.api.nvim_create_namespace("jb_replace_word_ns") -- Create a namespace for virtual text
  -- local prompt = "Replace: %s Length: [%d]"
  -- local current_win = vim.api.nvim_get_current_win()
  -- local bufnr = vim.api.nvim_get_current_buf()
  --
  -- -- Function to update virtual text using nvim_buf_set_extmark
  -- local function update_virtual_text(input)
  --   -- Clear previous extmark
  --   vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
  --
  --   local cursor_pos = vim.api.nvim_win_get_cursor(current_win)
  --   local line = cursor_pos[1] - 1 -- Line numbers are 0-indexed for extmarks
  --   local col = cursor_pos[2] -- Column where the virtual text will appear
  --
  --   -- Set virtual text as an extmark
  --   vim.api.nvim_buf_set_extmark(bufnr, ns_id, line, col, {
  --     virt_text = { { "[" .. #input .. "]", "Comment" } }, -- Text to display
  --     virt_text_pos = "right_align", -- Position at the end of the line
  --   })
  -- end
  --
  -- vim.ui.input({ prompt = string.format(prompt, word, #word) }, function(input)
  --   if input and #input > 0 then
  --     vim.cmd(string.format("%%s#%s#%s#g", word, input))
  --     vim.api.nvim_win_set_cursor(current_win, cpos)
  --   end
  -- end)
  --
  -- -- Set up an autocmd to listen for each character input and update the virtual text
  -- vim.api.nvim_create_autocmd("TextChangedI", {
  --   buffer = bufnr,
  --   callback = function()
  --     local cursor_input = vim.fn.getline("."):sub(cpos[2] + 1)
  --     update_virtual_text(cursor_input)
  --   end,
  -- })
  -- Store the current (parent) buffer number before opening vim.ui.input
  local parent_bufnr = vim.api.nvim_get_current_buf()
  local cpos = vim.api.nvim_win_get_cursor(0)
  local word = vim.fn.expand("<cword>")
  local ns_id = vim.api.nvim_create_namespace("replace_word_ns") -- Namespace for virtual text

  -- Function to update virtual text
  local function update_virtual_text(input)
    -- Clear any previous virtual text
    vim.api.nvim_buf_clear_namespace(parent_bufnr, ns_id, 0, -1)

    -- Set virtual text to show input length
    vim.api.nvim_buf_set_extmark(parent_bufnr, ns_id, cpos[1] - 1, 0, {
      virt_text = { { "[" .. #input .. "]", "Comment" } },
      virt_text_pos = "right_align",
    })
  end

  -- Display initial input prompt
  vim.ui.input({ prompt = string.format("Replace: %s Length: [%d]:", word, #word) }, function(input)
    if input and #input > 0 then
      update_virtual_text(input)
      -- Perform the replacement command in the parent buffer
      vim.api.nvim_set_current_buf(parent_bufnr)
      vim.cmd(string.format("%%s#%s#%s#g", word, input))

      -- Set the cursor back to its original position
      vim.api.nvim_win_set_cursor(0, cpos)

      -- Optionally clear virtual text after input
      vim.api.nvim_buf_clear_namespace(parent_bufnr, ns_id, 0, -1)
    end
  end)
end

return M
