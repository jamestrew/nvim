if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
else
  return
end

local M = {}

local _dev_dir = vim.fs.joinpath(vim.uv.os_homedir(), "projects")

function M.dev_dir(dir)
  dir = vim.fs.joinpath(_dev_dir, dir)
  if vim.uv.fs_stat(dir) then return dir end
end

function M.get_os_command_output(cmd, cwd)
  cwd = cwd or vim.uv.cwd()
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = require("plenary.job")
    :new({
      command = command,
      args = cmd,
      cwd = cwd,
      on_stderr = function(_, data) table.insert(stderr, data) end,
    })
    :sync()
  return stdout, ret, stderr
end

M.os = {
  home = os.getenv("HOME"),
  data = vim.fn.stdpath("data"),
  cache = vim.fn.stdpath("cache"),
  config = vim.fn.stdpath("config"),
  name = vim.uv.os_uname().sysname,
  cwd = vim.uv.cwd(),
  in_worktree = M.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })[1]
    == "true",
  in_bare = M.get_os_command_output({ "git", "rev-parse", "--is-bare-repository" })[1] == "true",
}

M.nnoremap = function(lhs, rhs, opts) vim.keymap.set("n", lhs, rhs, opts) end
M.inoremap = function(lhs, rhs, opts) vim.keymap.set("i", lhs, rhs, opts) end
M.vnoremap = function(lhs, rhs, opts) vim.keymap.set("v", lhs, rhs, opts) end
M.tnoremap = function(lhs, rhs, opts) vim.keymap.set("t", lhs, rhs, opts) end

M.nmap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.remap = true
  vim.keymap.set("n", lhs, rhs, opts)
end
M.imap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.remap = true
  vim.keymap.set("i", lhs, rhs, opts)
end
M.vmap = function(lhs, rhs, opts)
  opts = opts or {}
  opts.remap = true
  vim.keymap.set("v", lhs, rhs, opts)
end

M.modified_buf_count = function()
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then return false end
    if vim.fn.getbufinfo(b)[1].changed ~= 1 then return false end
    return true
  end, vim.api.nvim_list_bufs())

  return #bufnrs
end

M.clear_prompt = function() vim.api.nvim_command("normal :esc<CR>") end

return M
