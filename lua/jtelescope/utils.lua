local utils = require("utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local Path = require("plenary.path")

local M = {}

M.delete_file = function(prompt_bufnr)
  local fpath = action_state.get_selected_entry().value
  local ans = vim.fn.input("Are you sure you want to remove " .. fpath .. "? y/[N] ")
  utils.clear_prompt()
  if ans ~= "y" then return end

  if utils.is_dir(fpath) then
    Path:new(fpath):rmdir()
  else
    Path:new(fpath):rm()
  end
  print(fpath .. " successfully removed")
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

M.lsp_ref_entry = function(opts)
  opts = opts or {}

  local displayer = require("telescope.pickers.entry_display").create({
    separator = "▏",
    items = {
      { width = 8 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    local filename = require("telescope.utils").transform_path(opts, entry.filename)
    local line_info = { table.concat({ entry.lnum, entry.col }, ":"), "TelescopeResultsLineNr" }

    return displayer({
      line_info,
      filename,
    })
  end

  return function(entry)
    local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)

    return {
      valid = true,
      value = entry,
      ordinal = (not opts.ignore_filename and filename or "") .. " " .. entry.text,
      display = make_display,
      bufnr = entry.bufnr,
      filename = filename,
      lnum = entry.lnum,
      col = entry.col,
      text = entry.text,
      start = entry.start,
      finish = entry.finish,
    }
  end
end

M.open_using = function(finder)
  return function(prompt_bufnr)
    local current_finder = action_state.get_current_picker(prompt_bufnr).finder
    local entry = action_state.get_selected_entry()

    local entry_path
    if entry.ordinal == ".." then
      entry_path = Path:new(current_finder.path)
    else
      entry_path = action_state.get_selected_entry().Path
    end

    local path = entry_path:is_dir() and entry_path:absolute() or entry_path:parent():absolute()
    actions._close(prompt_bufnr, true)
    finder({ cwd = path })
  end
end

M.toggle_files = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local prompt = current_picker.prompt_title
  actions.close(prompt_bufnr)

  vim.schedule(function() require("jtelescope").project_files({}, prompt == "Git Files") end)
end

M.toggle_layout = function(prompt_bufnr)
  local opts = themes.get_dropdown({
    previewer = false,
  })
  local picker = action_state.get_current_picker(prompt_bufnr)

  if picker.hidden_layout == nil then
    picker.hidden_layout = {
      border = picker.border,
      borderchars = picker.borderchars,
      layout_config = picker.layout_config,
      layout_strategy = picker.layout_strategy,
      previewer = picker.previewer,
      results_title = picker.results_title,
      sorting_strategy = picker.sorting_strategy,
      theme = picker.theme,
    }

    picker.border = opts.border
    picker.borderchars = opts.borderchars
    picker.layout_config = opts.layout_config
    picker.layout_strategy = opts.layout_strategy
    picker.previewer = opts.previewer
    picker.results_title = opts.results_title
    picker.sorting_strategy = opts.sorting_strategy
    picker.theme = opts.theme
  else
    picker.border = picker.hidden_layout.border
    picker.borderchars = picker.hidden_layout.borderchars
    picker.layout_config = picker.hidden_layout.layout_config
    picker.layout_strategy = picker.hidden_layout.layout_strategy
    picker.previewer = picker.hidden_layout.previewer
    picker.results_title = picker.hidden_layout.results_title
    picker.sorting_strategy = picker.hidden_layout.sorting_strategy
    picker.theme = picker.hidden_layout.theme
    picker.hidden_layout = nil
  end

  picker:full_layout_update()
end

return M
