vim.g.mapleader = " "
vim.g.auto_save = false
vim.g.colors_name = "onedark"
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("lazy").setup("plugins")
require("autocmds")
require("user_commands")
require("mappings")

require("monkey")
require("ts_grammar")
