local import = require("utils").import

local configs = {
  ["fidget"] = { text = { spinner = { "🙈", "🙉", "🙊" } }, timer = { spinner_rate = 250 } },
  ["nvim-autopairs"] = {},
  ["colorizer"] = {"*"},
  ["gomove"] = {},
  ["neoclip"] = {},
  ["hop"] = { key = "tnhesoaiwfrudpclm" },
  ["scrollbar"] = {},
  ["nvim-surround"] = {},
  ["mason"] = {},
}

for plugin_name, config in pairs(configs) do
  import(plugin_name, config)
end
