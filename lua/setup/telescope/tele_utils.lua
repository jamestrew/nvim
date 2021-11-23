local utils = require("utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local Path = require("plenary.path")

local M = {}

M.delete_file = function(prompt_bufnr)
  local fpath = action_state.get_selected_entry().value
  local ans = vim.fn.input("Are you sure you want to remove " .. fpath .. "? y/[N] ")
  utils.clear_prompt()
  if ans ~= "y" then
    return
  end

  if utils.is_dir(fpath) then
    Path:new(fpath):rmdir()
  else
    Path:new(fpath):rm()
  end
  print(fpath .. " successfully removed")

  actions.close(prompt_bufnr)
end

M.rename_file = function()
  local fpath = action_state.get_selected_entry().value
  local new_name = vim.fn.input("Rename ", fpath)
  utils.clear_prompt()
  Path:new(fpath):rename({ new_name = new_name })
end

M.create_file = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local fpath = ""
  if entry == nil then
    fpath = vim.loop.cwd()
  else
    fpath = entry.value
  end

  local new_file = vim.fn.input("Create file: ", fpath .. "/")
  utils.clear_prompt()

  if not utils.is_dir(new_file) then
    actions.close(prompt_bufnr)
    Path:new(new_file):touch({ parents = true })
    vim.cmd(string.format(":e %s", new_file))
  else
    print("Given path not a valid file name")
  end
end

M.yank_fpath = function()
  local entry = action_state.get_selected_entry()
  vim.fn.setreg("+", entry.value)
end

M.alt_scroll = function(map)
    map("i", "<C-p>", actions.move_selection_previous)
    map("i", "<C-n>", actions.move_selection_next)
    map("n", "<C-p>", actions.move_selection_previous)
    map("n", "<C-n>", actions.move_selection_next)
    return true
end


return M
