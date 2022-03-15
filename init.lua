Working = false
local g = vim.g
require("impatient").enable_profile()
require("plugins")
require("packer_compiled")
require("options")

g.mapleader = " "
g.auto_save = false
g.colors_name = "onedark"

require("mappings")
