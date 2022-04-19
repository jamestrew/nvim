Work = os.getenv("NVIM_WORK") or false
local g = vim.g
g.mapleader = " "
g.auto_save = false
g.colors_name = "onedark"

require("impatient").enable_profile()
require("plugins")
require("packer_compiled")
require("options")
require("autocmds")
require("mappings")
