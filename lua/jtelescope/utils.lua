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

M.git_hunks_entry = function(opts)
  opts = opts or {}

  local displayer = require("telescope.pickers.entry_display").create({
    separator = "▏",
    items = {
      { width = 5 },
      { width = 22 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    local diff_map = {
      add = "TeleDiffAdd",
      delete = "TeleDiffDelete",
      change = "TeleDiffChange",
    }
    return displayer({
      { entry.lnum, "TelescopeResultsLineNr" },
      { entry.head, diff_map[entry.type] },
      entry.text:gsub(".* | ", ""),
    })
  end

  return function(entry)

    return {
      valid = true,
      value = entry,
      ordinal = (not opts.ignore_filename and entry.filename or "") .. " " .. entry.text,
      display = make_display,
      bufnr = entry.bufnr,
      filename = entry.filename,
      lnum = entry.lnum,
      col = 1,
      head = entry.head,
      text = entry.text,
      type = entry.type,
    }
  end
end

M.open_using = function(finder)
  return function(prompt_bufnr)
    print("open_using")
    local entry_path = action_state.get_selected_entry().Path
    local path = entry_path:is_dir() and entry_path:absolute() or entry_path:parent():absolute()
    actions._close(prompt_bufnr, true)
    finder({ cwd = path })
  end
end

return M
