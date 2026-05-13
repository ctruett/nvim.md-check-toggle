# nvim.md-check-toggle

A lightweight, highly configurable Neovim plugin to toggle Markdown checkboxes. Supports custom cycle states (e.g., `[ ]` -> `[/]` -> `[x]`) and visual mode for bulk toggling.

## Features

- **Toggle Checkboxes**: Quickly flip between `[ ]` and `[x]`.
- **Custom States**: Define your own cycle (e.g., `[ ]` -> `[/]` -> `[?]` -> `[x]`).
- **Visual Mode**: Select multiple lines and toggle them all at once.
- **Smart Logic**: Automatically handles indented lists, numbered lists, and capital `[X]`.
- **Filetype Sensitive**: Default mappings only apply to Markdown files.

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "ctruett/nvim.md-check-toggle",
  ft = "markdown", -- optional, for lazy loading
  opts = {
    -- mapping = "<leader>cc", -- default mapping
    -- states = { "[ ]", "[x]" }, -- default states
  },
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use({
  "ctruett/nvim.md-check-toggle",
  config = function()
    require("md-check-toggle").setup({})
  end,
})
```

## Configuration

The default configuration is:

```lua
require('md-check-toggle').setup({
  -- The states the checkbox cycles through
  states = { "[ ]", "[x]" },
  
  -- The mapping used in normal and visual mode
  -- Set to false or nil to disable default mapping
  mapping = "<leader>cc",
})
```

### Custom Workflow Example

If you want an "in-progress" state:

```lua
require('md-check-toggle').setup({
  states = { "[ ]", "[/]", "[x]" },
})
```

## Usage

- **Normal Mode**: Press `<leader>cc` on a line with a checkbox.
- **Visual Mode**: Select multiple lines and press `<leader>cc`.
- **Command**: Use `:MDCheckToggle` (also supports ranges).

## License

MIT
