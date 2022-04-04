local Path = require("plenary.path")
local Job = require("plenary.job")

-- for debuging
_G.dump = function(...)
  print(vim.inspect(...))
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

local M = {}

function M.get_os_command_output(cmd, cwd)
  cwd = cwd or vim.loop.cwd()
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job
    :new({
      command = command,
      args = cmd,
      cwd = cwd,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end,
    })
    :sync()
  return stdout, ret, stderr
end

M.os = {
  home = os.getenv("HOME"),
  data = vim.fn.stdpath("data"),
  cache = vim.fn.stdpath("cache"),
  config = vim.fn.stdpath("config"),
  name = vim.loop.os_uname().sysname,
  cwd = vim.loop.cwd(),
  in_worktree = M.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })[1] == "true",
  in_bare = M.get_os_command_output({ "git", "rev-parse", "--is-bare-repository" })[1] == "true",
}

M.functions = {}

function M.execute(id)
  local func = M.functions[id]
  if not func then
    error("Function does not exist: " .. id)
  end
  return func()
end

-- mapping support
local map = function(mode, key, cmd, opts, defaults)
  opts = vim.tbl_deep_extend("force", { silent = true }, defaults or {}, opts or {})

  if type(cmd) == "function" then
    table.insert(M.functions, cmd)
    if opts.expr then
      cmd = ([[luaeval('require("util").execute(%d)')]]):format(#M.functions)
    else
      cmd = ("<cmd>lua require('utils').execute(%d)<cr>"):format(#M.functions)
    end
  end
  if opts.buffer ~= nil then
    local buffer = opts.buffer
    opts.buffer = nil
    return vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, opts)
  else
    return vim.api.nvim_set_keymap(mode, key, cmd, opts)
  end
end

function M.map(mode, key, cmd, opts, defaults)
  return map(mode, key, cmd, opts, defaults)
end

-- nmap keys action
function M.nmap(key, cmd, opts)
  return map("n", key, cmd, opts)
end
function M.vmap(key, cmd, opts)
  return map("v", key, cmd, opts)
end
function M.xmap(key, cmd, opts)
  return map("x", key, cmd, opts)
end
function M.imap(key, cmd, opts)
  return map("i", key, cmd, opts)
end
function M.omap(key, cmd, opts)
  return map("o", key, cmd, opts)
end
function M.smap(key, cmd, opts)
  return map("s", key, cmd, opts)
end
function M.tmap(key, cmd, opts)
  return map("t", key, cmd, opts)
end

local nore = { noremap = true }
function M.nnoremap(key, cmd, opts)
  return map("n", key, cmd, opts, nore)
end
function M.vnoremap(key, cmd, opts)
  return map("v", key, cmd, opts, nore)
end
function M.xnoremap(key, cmd, opts)
  return map("x", key, cmd, opts, nore)
end
function M.inoremap(key, cmd, opts)
  return map("i", key, cmd, opts, nore)
end
function M.onoremap(key, cmd, opts)
  return map("o", key, cmd, opts, nore)
end
function M.snoremap(key, cmd, opts)
  return map("s", key, cmd, opts, nore)
end
function M.tnoremap(key, cmd, opts)
  return map("t", key, cmd, opts, nore)
end

M.modified_buf_count = function()
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      return false
    end
    if vim.fn.getbufinfo(b)[1].changed ~= 1 then
      return false
    end
    return true
  end, vim.api.nvim_list_bufs())

  return #bufnrs
end

M.is_dir = function(path)
  return path:sub(-1, -1) == Path.path.sep
end

M.clear_prompt = function()
  vim.api.nvim_command("normal :esc<CR>")
end

M.save_and_source = function()
  print("savin' and sourcin'")
  local ft = vim.bo.filetype
  vim.cmd(":silent! w")
  if ft == "vim" then
    vim.cmd(":source %")
  elseif ft == "lua" then
    vim.cmd(":luafile %")
  end
end

M.trim_TDAMPA = function(name)
  return name:gsub("^.*TDAMPA--", "")
end

return M
