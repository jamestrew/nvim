Work = os.getenv("NVIM_WORK") or false
vim.g.mapleader = " "
vim.g.auto_save = false
vim.g.colors_name = "onedark"
vim.opt.termguicolors = true

require("plugins")
require("options")
require("autocmds")
require("user_commands")
require("mappings")
