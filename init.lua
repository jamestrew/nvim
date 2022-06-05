Work = os.getenv("NVIM_WORK") or false
vim.g.mapleader = " "
vim.g.auto_save = false
vim.g.colors_name = "onedark"

require("impatient").enable_profile()
require("plugins")
require("packer_compiled")
require("options")
require("autocmds")
require("mappings")
