# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## TODO

Integrate Custom completion menu into CMP via noice

1. Capture completion data (Noice should already be doing this. Just need to check)
2. Create the custom floating window
3. Menu needs to update as user types
   a. So we need a `CursorMovedI` event that would trigger the popup instead of hitting just `<TAB>` to update it

on to something here with VS language server
dotnet `C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/CommonExtensions/Microsoft/VBCSharp/LanguageServices/InteractiveHost/Core/InteractiveHost64.dll` <PIPE NAME> PID 'en-US' 'en-US'
