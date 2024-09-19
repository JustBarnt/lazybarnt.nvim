# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## TODO

Integrate Custom completion menu into CMP via noice

1. Capture completion data (Noice should already be doing this. Just need to check)
2. Create the custom floating window
3. Menu needs to update as user types
   a. So we need a `CursorMovedI` event that would trigger the popup instead of hitting just `<TAB>` to update it
