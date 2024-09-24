# New Neovim Config

Plugin Manager
`lazy.nvim` or `rocks.nvim`

## Order

1. LSP
   - Setup like `LazyVim`
2. Treesitter
3. Auto-Completion
4. Max Nushell support
5. gitsigns
6. Undotree
7. Linting
8. Formatting
9. Colorscheme
10. Grugfar
11. vim-fugitive

### Plugins

#### Coding

##### LSP

- [ ] lazydev
  - [ ] luvit-meta
- [ ] neoconf
- [ ] mason-lspconfig.nvim
- [ ] mason-nvim-dap.nvim
- [ ] mason.nvim
- [ ] nvim-lspconfig
  - [ ] nvim-lint
  - [ ] conform
  - [ ] fastaction
  - [ ] increname
  - [ ] roslyn.nvim
  - [ ] schemastore.nvim
- [ ] nvim-treesitter
  - [ ] nvim-treesitter-context
  - [ ] nvim-treesitter-textobjects
  - [ ] nvim-ts-autotag
- [ ] nvim-surround
- [ ] mini.pairs
- [ ] mini.ai
- [ ] vim-sleuth
- [ ] plenary.nvim

##### Debugging

- [ ] nvim-dap
  - [ ] nvim-dap-ui
  - [ ] nvim-dap-virtual-text
  - [ ] nvim-nio

##### Auto-Complete

- [ ] nvim-cmp
  - [ ] nvim-snippets
  - [ ] cmp-buffer
  - [ ] cmp-cmldline
  - [ ] cmp-nvim-lsp
  - [ ] cmp-path
  - [ ] tailwindcss-colorizer-cmp
  - [ ] friendly-snippets

#### UI

- [ ] telescope
- [ ] noice
- [ ] nvim-notify
- [ ] project-explorer.nvim
- [ ] which-key.nvim
- [ ] trouble.nvim

##### Utils

- [ ] mini.hipatterns
- [ ] harpoon.nvim
- [ ] dressing.nvim
- [ ] mini.icons
- [ ] grugfar
- [ ] render-markdown
- [ ] dashboard-nvim
- [ ] hlchunk.nvim
- [ ] nui.nvim
- [ ] ts-comments
- [ ] todo-comments

### Misc

- [ ] flash.nvim
- [ ] bufferline.nvim
- [ ] neo-tree.nvim
- [ ] numb.nvim
- [ ] persitance.nvim

### Themes

- [ ] Eldritch.nvim
- [ ] tokyonight.nvim
- [ ] yorumi.nvim

### Config

- [ ] Border Config
- [ ] Telescope Config
  - Includes layout, UI design, and results filters
- [ ] Completion Config
- [ ] Statusline (Custom)
- [ ] Statuscolumn (Custom)

- [ ] Global config values to enable or disable items.
- [ ] Global use functions (LazyVim inspired)
- [ ] Custom handlers and actions for .NET projects
  - `X.Designer.cs` Automatically open in VisualStudio
  - Hidden from neovim when searching with Telescope
- [ ] Telescope ignore options -> Glob pattern
- [ ] Lazy loading plugins (read how LazyVim achieves this)
- [ ] Handle large files by disabling most plugins

#### Utils

- [ ] Ability to inverse booleans/null|undefined/0-1
- [ ] Create an editor config file when accessing a recognized root_dir that doesn't have one
- [ ] Unit tests

### Treesitter

Setup text objects for around function, inside function, etc
