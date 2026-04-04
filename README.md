# nvim

Personal Neovim config for general development work.

It is built around `lazy.nvim` and mostly focused on:

- Lua
- Python
- JavaScript and TypeScript
- Go
- C and C++
- Nix
- Rust

## What it includes

- LSP-based editing and diagnostics
- Treesitter for syntax highlighting and text objects
- Formatting and linting helpers
- Git integration
- Debugging support
- A small set of UI and editing plugins

## Structure

- `init.lua`: bootstrap and core startup
- `lua/config`: options, mappings, autocmds, and user commands
- `lua/plugins`: plugin definitions
- `after/lsp`: per-server LSP overrides
- `after/ftplugin`: filetype-specific settings
- `colors` and `lua/themes`: colorscheme definitions

## Notes

This config is still changing and tuned to my workflow, but it is kept modular enough to lift pieces out as needed.
