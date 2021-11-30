require("impatient")
require("plugins")
require("packer_compiled")
require("options")

local g = vim.g

g.mapleader = " "
g.auto_save = false

require("mappings")
