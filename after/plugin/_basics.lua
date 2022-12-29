local import = require("utils").import

local configs = {
  ["fidget"] = { text = { spinner = "bouncing_ball" }, timer = { spinner_rate = 250 } },
  ["nvim-autopairs"] = {},
  ["colorizer"] = { "*" },
  ["gomove"] = {},
  ["neoclip"] = {},
  ["hop"] = { key = "tnhesoairucldp" },
  ["scrollbar"] = {},
  ["nvim-surround"] = {},
  ["mason"] = {},
  ["smart-splits"] = {},
  ["no-neck-pain"] = { debug = false, buffers = { right = { enabled = false } } },
}

for plugin_name, config in pairs(configs) do
  import(plugin_name, config)
end

--[[
  Mason installs:
    ◍ typescript-language-server
    ◍ sqlfluff
    ◍ gopls
    ◍ stylua
    ◍ sql-formatter
    ◍ pyright
    ◍ delve
    ◍ prettier
    ◍ bash-language-server
    ◍ go-debug-adapter
    ◍ black
    ◍ clang-format
    ◍ clangd
    ◍ css-lsp
    ◍ emmet-ls
    ◍ eslint-lsp
    ◍ goimports
    ◍ golines
    ◍ html-lsp
    ◍ json-lsp
    ◍ lua-language-server
    ◍ markdownlint
    ◍ sqls
    ◍ vim-language-server
]]
