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
  ["no-neck-pain"] = { debug = false, buffers = { right = false } },
}

for plugin_name, config in pairs(configs) do
  import(plugin_name, config)
end

--[[
  Mason installs:
    ◍ bash-language-server
    ◍ black
    ◍ clang-format
    ◍ clangd
    ◍ css-lsp
    ◍ delve
    ◍ emmet-ls
    ◍ eslint-lsp
    ◍ go-debug-adapter
    ◍ golines
    ◍ gopls
    ◍ html-lsp
    ◍ json-lsp
    ◍ lua-language-server
    ◍ markdownlint
    ◍ prettier
    ◍ pyright
    ◍ sqlls
    ◍ stylua
    ◍ typescript-language-server
    ◍ vim-language-server
]]
