local M = {}

local _dev_dir = vim.fs.joinpath(vim.uv.os_homedir(), "projects")

function M.dev_dir(dir)
  dir = vim.fs.joinpath(_dev_dir, dir)
  if vim.uv.fs_stat(dir) then return dir end
end

M.os = {
  home = os.getenv("HOME"),
  data = vim.fn.stdpath("data"),
  cache = vim.fn.stdpath("cache"),
  config = vim.fn.stdpath("config"),
  name = vim.uv.os_uname().sysname,
  cwd = vim.uv.cwd(),

  in_worktree = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }):wait().code == 0,
  in_bare = vim
    .system({ "git", "rev-parse", "--is-bare-repository" }, { text = true })
    :wait().stdout == "true\n",
}

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
