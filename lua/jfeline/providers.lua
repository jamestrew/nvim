local Path = require("plenary.path")

local utils = require("utils")

local M = {}

M.file_name_custom = function()
  local prefix, filename, suffix = "", vim.fn.expand("%:p"), ""

  prefix = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype) or ""
  local max_len = 150
  filename = Path:new(filename):make_relative(vim.loop.cwd())
  if #filename > max_len then filename = Path:new(filename):shorten() end

  if vim.bo.modifiable then
    if vim.bo.modified then suffix = "" end
  else
    suffix = ""
  end

  return string.format("%s %s %s", prefix, filename, suffix)
end

M.current_dir = function()
  local max_len = 25
  local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  dir_name = utils.trim_TDAMPA(dir_name)
  if #dir_name > max_len then dir_name = dir_name:sub(0, max_len) .. "..." end
  return "  " .. dir_name .. " "
end

M.lsp_client = function()
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    return " No LSP "
  else
    return ""
  end
end

M.modified_buf_count = function()
  local unsaved_cnt = utils.modified_buf_count()
  if unsaved_cnt > 0 then return "λ" .. unsaved_cnt end
  return ""
end

M.git_branch = function()
  local max_len = 25
  local branch = vim.g.gitsigns_head or vim.b.gitsigns_head
  branch = utils.trim_TDAMPA(branch)
  if #branch > max_len then branch = branch:sub(1, max_len) .. ".." end
  return " " .. branch .. " "
end

M.file_name_simple = function()
  local prefix, filename, suffix = "", vim.fn.expand("%:p:t"), ""

  if vim.bo.modifiable then
    if vim.bo.modified then prefix = "[+]" end
  else
    prefix = "[-]"
  end

  return string.format("%s %s %s", prefix, filename, suffix)
end

return M
