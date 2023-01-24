local import = require("utils").import

local configs = {
  ["fidget"] = { text = { spinner = "bouncing_ball" }, timer = { spinner_rate = 250 } },
  ["nvim-autopairs"] = {},
  ["colorizer"] = { "*", "!go" },
  ["gomove"] = {},
  ["neoclip"] = {},
  ["scrollbar"] = {},
  ["nvim-surround"] = {},
  ["mason"] = {},
  ["smart-splits"] = {},
  ["auto-hlsearch"] = {},
  ["messages"] = {},
}

for plugin_name, config in pairs(configs) do
  import(plugin_name, config)
end

--[[
  Mason installs:
    ◍ typescript-language-server
    ◍ sql-formatter
    ◍ stylua
    ◍ pyright
    ◍ bash-language-server
    ◍ markdownlint
    ◍ clang-format
    ◍ prettier
    ◍ lua-language-server
    ◍ go-debug-adapter
    ◍ black
    ◍ clangd
    ◍ css-lsp
    ◍ delve
    ◍ emmet-ls
    ◍ eslint-lsp
    ◍ goimports
    ◍ golines
    ◍ gopls
    ◍ html-lsp
    ◍ json-lsp
    ◍ sqlfluff
    ◍ sqls
    ◍ vim-language-server
]]
