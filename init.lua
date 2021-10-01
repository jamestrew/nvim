require("plugins")
require("options")

local g = vim.g

g.mapleader = " "
g.auto_save = false

require("mappings")

require("utils").hideStuff()
