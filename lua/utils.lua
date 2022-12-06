local Path = require("plenary.path")
local Job = require("plenary.job")

-- for debuging
_G.dump = function(...) print(vim.inspect(...)) end

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
  local stdout, ret = Job:new({
    command = command,
    args = cmd,
    cwd = cwd,
    on_stderr = function(_, data) table.insert(stderr, data) end,
  }):sync()
  return stdout, ret, stderr
end

M.os = {
  home = os.getenv("HOME"),
  data = vim.fn.stdpath("data"),
  cache = vim.fn.stdpath("cache"),
  config = vim.fn.stdpath("config"),
  name = vim.loop.os_uname().sysname,
  cwd = vim.loop.cwd(),
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

M.is_dir = function(path) return path:sub(-1, -1) == Path.path.sep end

M.clear_prompt = function() vim.api.nvim_command("normal :esc<CR>") end

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

M.trim_TDAMPA = function(name) return name:gsub("^.*TDAMPA--", "") end

M.plugin_urls = function()
  local plugins = {}
  for _, plug_data in pairs(_G.packer_plugins) do
    if plug_data.url then table.insert(plugins, plug_data.url) end
  end
  table.sort(plugins)

  local file = io.open("work/plugin_urls.txt", "w")
  io.output(file)

  for _, url in pairs(plugins) do
    io.write(string.format("%s\n", url))
  end
  io.close(file)
end

M.import = function(module, setup)
  local ok, mod = pcall(require, module)

  if not ok then
    vim.notify(string.format("%s not installed", module), vim.log.levels.WARN)
    return mod
  end

  if setup then mod.setup(setup) end

  return mod
end

M.rsync_work_files = function(opts)
  opts = opts or {}
  local worktree = require("git-worktree")
  local project_root = "/home/trewja2/projects/src"
  local srv_root = "/srv/www/analytics/src"
  if not Work or worktree.get_root() ~= project_root then
    print("Rsync aborted - not in project root.")
    return
  end

  local worktree_path = Path:new(worktree.get_current_worktree_path())

  local cmd
  if opts.single_file then
    local filename = vim.api.nvim_buf_get_name(0)
    local rel_filename = Path:new(filename):make_relative(worktree_path.filename)
    local dest_path = Path:new(srv_root):joinpath(rel_filename)
    cmd = { "rsync", filename, dest_path.filename }
  else
    cmd = {
      "rsync",
      "-O",
      "-av",
      "--exclude={'lib/c_lib/_c_lib.so','lib/c_lib/bin','node_modules','build','.idea'}",
      worktree_path.filename .. "/",
      srv_root,
    }
  end
  M.get_os_command_output(cmd)
end

return M
