local utils = require("config.utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local Path = require("plenary.path")
local fb_utils = require("telescope._extensions.file_browser.utils")

local M = {}

M.delete_file = function(_)
  local fpath = action_state.get_selected_entry().value
  local ans = vim.fn.input("Are you sure you want to remove " .. fpath .. "? y/[N] ")
  utils.clear_prompt()
  if ans ~= "y" then return end

  if vim.fn.isdirectory(fpath) == 0 then
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
  local prompt = action_state.get_current_line()
  ---@type Path
  local prompt_path = Path:new(prompt)
  local ok
  if prompt:match("/$") then
    ok = prompt_path:mkdir({ parents = true, exists_ok = false })
  else
    ok = prompt_path:touch({ parents = true })
  end

  if ok then
    actions.close(prompt_bufnr)
    vim.cmd.e(prompt_path:absolute())
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
    local selections = fb_utils.get_selected_files(prompt_bufnr, false)
    local search_dirs = vim.tbl_map(function(path) return path:absolute() end, selections)
    if vim.tbl_isempty(search_dirs) then
      local current_finder = action_state.get_current_picker(prompt_bufnr).finder
      search_dirs = { current_finder.path }
    end
    actions.close(prompt_bufnr)
    finder({ search_dirs = search_dirs })
  end
end

local cycle_themes = {
  themes.get_dropdown({ previewer = false }),
  themes.get_ivy(),
}

M.cycle_layouts = {}
for _, theme in ipairs(cycle_themes) do
  table.insert(M.cycle_layouts, {
    layout_strategy = theme.layout_strategy,
    layout_config = theme.layout_config,
    previewer = theme.previewer,
  })
end

M.current_bufr_dir = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder
  local bufr_path = Path:new(vim.fn.expand("#:p"))
  local bufr_parent_path = bufr_path:parent():absolute()

  if finder.path ~= bufr_parent_path then
    finder.path = bufr_parent_path
    fb_utils.selection_callback(current_picker, bufr_path:absolute())
  else
    finder.path = vim.uv.cwd()
  end
  fb_utils.redraw_border_title(current_picker)
  current_picker:refresh(finder, {
    new_prefix = fb_utils.relative_path_prefix(finder),
    reset_prompt = true,
    multi = current_picker._multi,
  })
end

M.diffsplit = function(prompt_bufnr)
  local fpath = action_state.get_selected_entry().path
  actions.close(prompt_bufnr)
  vim.cmd.diffsplit(fpath)
end

---@alias boxkind "vertical"|"horizontal"|"minimal"|"tiny"

---@type {current: boxkind, last: boxkind?}
local boxkind_state = {
  current = "horizontal",
  last = nil,
}

M.create_fused_layout = function(TSLayout)
  local Layout = require("nui.layout")
  local Popup = require("nui.popup")

  local function make_popup(options)
    local popup = Popup(options)
    function popup.border:change_title(title) popup.border.set_text(popup.border, "top", title) end
    return TSLayout.Window(popup)
  end

  return function(picker)
    local border = {
      results = {
        top_left = "┌",
        top = "─",
        top_right = "┬",
        right = "│",
        bottom_right = "",
        bottom = "",
        bottom_left = "",
        left = "│",
      },
      results_patch = {
        minimal = {
          top_left = "┌",
          top_right = "┐",
        },
        horizontal = {
          top_left = "┌",
          top_right = "┬",
        },
        vertical = {
          top_left = "├",
          top_right = "┤",
        },
      },
      prompt = {
        top_left = "├",
        top = "─",
        top_right = "┤",
        right = "│",
        bottom_right = "┘",
        bottom = "─",
        bottom_left = "└",
        left = "│",
      },
      prompt_patch = {
        minimal = {
          bottom_right = "┘",
        },
        horizontal = {
          bottom_right = "┴",
        },
        vertical = {
          bottom_right = "┘",
        },
      },
      preview = {
        top_left = "┌",
        top = "─",
        top_right = "┐",
        right = "│",
        bottom_right = "┘",
        bottom = "─",
        bottom_left = "└",
        left = "│",
      },
      preview_patch = {
        minimal = {},
        horizontal = {
          bottom = "─",
          bottom_left = "",
          bottom_right = "┘",
          left = "",
          top_left = "",
        },
        vertical = {
          bottom = "",
          bottom_left = "",
          bottom_right = "",
          left = "│",
          top_left = "┌",
        },
      },
    }

    local results = make_popup({
      focusable = false,
      border = {
        style = border.results,
        text = {
          top = picker.results_title,
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder",
      },
    })

    local prompt = make_popup({
      enter = true,
      border = {
        style = border.prompt,
        text = {
          top = picker.prompt_title,
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder",
      },
    })

    local preview = make_popup({
      focusable = false,
      border = {
        style = border.preview,
        text = {
          top = picker.preview_title,
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder",
      },
    })

    ---@type table<boxkind, NuiLayout.Box>
    local box_by_kind = {
      vertical = Layout.Box({
        Layout.Box(preview, { grow = 1 }),
        Layout.Box(results, { grow = 1 }),
        Layout.Box(prompt, { size = 3 }),
      }, { dir = "col" }),
      horizontal = Layout.Box({
        Layout.Box({
          Layout.Box(results, { grow = 1 }),
          Layout.Box(prompt, { size = 3 }),
        }, { dir = "col", size = "50%" }),
        Layout.Box(preview, { size = "50%" }),
      }, { dir = "row" }),
      minimal = Layout.Box({
        Layout.Box(results, { grow = 1 }),
        Layout.Box(prompt, { size = 3 }),
      }, { dir = "col" }),
      tiny = Layout.Box({
        Layout.Box(results, { grow = 1 }),
        Layout.Box(prompt, { size = 3 }),
      }, { dir = "col" }),
    }

    ---@return NuiLayout.Box
    ---@return boxkind
    local function get_box()
      local strategy = picker.layout_strategy
      if strategy == "vertical" or strategy == "horizontal" then
        return box_by_kind[strategy], strategy
      end

      local height, width = vim.o.lines, vim.o.columns
      local box_kind = "horizontal"
      if width < 150 then
        box_kind = "vertical"
        if height < 40 then box_kind = "minimal" end
      end
      return box_by_kind[box_kind], box_kind
    end

    local function prepare_layout_parts(picker, layout, boxkind)
      layout.results = results
      results.border:set_style(border.results_patch[boxkind])

      layout.prompt = prompt
      prompt.border:set_style(border.prompt_patch[boxkind])

      if boxkind == "minimal" or boxkind == "tiny" then
        layout.preview = nil
      else
        layout.preview = preview
        preview.border:set_style(border.preview_patch[boxkind])
      end
    end

    local function get_layout_config(boxkind)
      if boxkind == "tiny" then
        return {
          relative = "editor",
          position = {
            row = 2,
            col = "50%",
          },
          size = {
            width = "40%",
            height = 10,
          },
        }
      end
      return {
        relative = "editor",
        position = "50%",
        size = picker.layout_config[boxkind == "minimal" and "vertical" or boxkind].size,
      }
    end

    local box, box_kind = get_box()
    local layout = Layout(get_layout_config(box_kind), box)

    ---@diagnostic disable-next-line: inject-field
    layout.picker = picker
    prepare_layout_parts(picker, layout, box_kind)

    local layout_update = layout.update
    function layout:update()
      local new_box, new_boxkind
      if boxkind_state.current == "tiny" then
        new_box = box_by_kind["tiny"]
        new_boxkind = "tiny"
      else
        new_box, new_boxkind = get_box()
        boxkind_state.current = new_boxkind
      end
      prepare_layout_parts(self, layout, box_kind)
      layout_update(self, get_layout_config(new_boxkind), new_box)
    end

    return TSLayout(layout)
  end
end

M.toggle_tiny_layout = function(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)

  if boxkind_state.current == "tiny" then
    boxkind_state.current = boxkind_state.last or "horizontal"
    boxkind_state.last = "tiny"
  else
    boxkind_state.last = boxkind_state.current
    boxkind_state.current = "tiny"
  end

  picker:full_layout_update()
end

return M
