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

M.nnoremap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end
M.inoremap = function(lhs, rhs, opts)
  vim.keymap.set("i", lhs, rhs, opts)
end
M.vnoremap = function(lhs, rhs, opts)
  vim.keymap.set("v", lhs, rhs, opts)
end
M.tnoremap = function(lhs, rhs, opts)
  vim.keymap.set("t", lhs, rhs, opts)
end

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

M.plugin_urls = function()
  local plugins = {}
  for _, plug_data in pairs(_G.packer_plugins) do
    if plug_data.url then
      table.insert(plugins, plug_data.url)
    end
  end
  table.sort(plugins)

  local file = io.open("work/plugin_urls.txt", "w")
  io.output(file)

  for _, url in pairs(plugins) do
    io.write(string.format("%s\n", url))
  end
  io.close(file)
end

M.winbar = function()
  if vim.api.nvim_eval_statusline("%f", {})["str"] == "[No Name]" then
    return ""
  end
  return "%#WinBarSeparator#"
    .. "%*"
    .. "%#WinBarContent#"
    .. "%f"
    .. "%*"
    .. "%#WinBarSeparator#"
    .. "%*"
end

return M
