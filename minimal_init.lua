-- DO NOT change the paths and don't remove the colorscheme
-- minimal_init.lua
local on_windows = vim.loop.os_uname().version:match("Windows")

local function join_paths(...)
  local path_sep = on_windows and "\\" or "/"
  local result = table.concat({ ... }, path_sep)
  return result
end

vim.cmd([[set runtimepath=$VIMRUNTIME]])

local temp_dir = vim.loop.os_getenv("TEMP") or "/tmp"

vim.cmd("set packpath=" .. join_paths(temp_dir, "nvim", "site"))

local package_root = join_paths(temp_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

local function load_plugins()
  require("packer").startup({
    {
      "wbthomason/packer.nvim",
      "folke/noice.nvim",
      "MunifTanjim/nui.nvim",
      "TimUntersberger/neogit",
      "nvim-lua/plenary.nvim",

      "folke/tokyonight.nvim",
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  })
end

_G.load_config = function()
  vim.cmd([[colorscheme tokyonight]])
  require("neogit").setup()
  require("noice").setup()
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  load_plugins()
  require("packer").sync()
  vim.cmd([[autocmd User PackerComplete ++once lua load_config()]])
else
  load_plugins()
  require("packer").sync()
  _G.load_config()
end
local root = vim.fn.fnamemodify("./.repro", ":p")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
local plugins = {
  "folke/tokyonight.nvim",
  -- add any other plugins here
}
require("lazy").setup(plugins, {
  root = root .. "/plugins",
})

vim.cmd.colorscheme("tokyonight")
-- add anything else here
