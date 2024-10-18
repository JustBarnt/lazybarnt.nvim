return {
  "jackMort/tide.nvim",
  config = function()
    require("tide"):setup({
      keys = {
        leader = ";", -- Leader key to prefix all Tide commands
        panel = ";", -- Open the panel (uses leader key as prefix)
        add_item = "a", -- Add a new item to the list (leader + 'a')
        delete = "d", -- Remove an item from the list (leader + 'd')
        clear_all = "x", -- Clear all items (leader + 'x')
        horizontal = "-", -- Split window horizontally (leader + '-')
        vertical = "|", -- Split window vertically (leader + '|')
      },
      animation_duration = 150, -- Animation duration in milliseconds
      animation_fps = 60, -- Frames per second for animations
      hints = {
        dictionary = "qwertzuiopsfghjklycvbnm", -- Key hints for quick access
      },
    })
  end,
}
