local utils = require("utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")
local themes = require("telescope.themes")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")

local tele_utils = require("plugins.telescope.utils")

local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").git_files({
    prompt_title = "< Nvim >",
    cwd = "~/.config/nvim/",
  })
end

M.project_files = function(opts, no_ignore)
  opts = opts or {}
  no_ignore = vim.F.if_nil(no_ignore, false)
  opts.attach_mappings = function(_, map)
    map("i", "<M-c>", tele_utils.create_file)
    map("i", "<M-d>", tele_utils.delete_file)
    map("i", "<M-r>", tele_utils.rename_file)
    map("i", "<M-y>", tele_utils.yank_fpath)
    map("i", "<M-s>", tele_utils.diffsplit)
    map("n", "yy", tele_utils.yank_fpath)
    map({ "n", "i" }, "<C-f>", function(prompt_bufnr)
      local prompt = action_state.get_current_line()
      actions.close(prompt_bufnr)
      no_ignore = not no_ignore
      M.project_files({ default_text = prompt }, no_ignore)
    end)
    return true
  end

  if no_ignore then
    opts.find_command =
      { "rg", "--files", "--color", "never", "--hidden", "--no-ignore", "--glob", "!.git" }
    opts.prompt_title = "Find Files <ALL>"
    require("telescope.builtin").find_files(opts)
  else
    opts.prompt_title = "Find Files"
    require("telescope.builtin").find_files(opts)
  end
end

M.live_grep = function(opts, use_args)
  opts = opts or {}
  use_args = vim.F.if_nil(use_args, false)
  opts.attach_mappings = function(_, map)
    map({ "n", "i" }, "<C-f>", function(prompt_bufnr)
      local prompt = action_state.get_current_line()
      actions.close(prompt_bufnr)
      if #prompt > 0 then opts.default_text = string.format([["%s"]], prompt) end
      require("telescope").extensions.live_grep_args.live_grep_args(opts)
    end)
    return true
  end

  require("telescope.builtin").live_grep(opts)
end

M.buffers = function(opts)
  opts = opts
    or themes.get_dropdown({
      previewer = false,
      attach_mappings = function(_, map)
        map({ "n", "i" }, "<M-d>", actions.delete_buffer)
        return true
      end,
    })
  require("telescope.builtin").buffers(opts)
end

M.git_worktrees = function()
  local opts = themes.get_dropdown()
  opts.attach_mappings = function(_, map)
    map("i", "<A-c>", actions.git_create_branch)
    map("n", "c", actions.git_create_branch)
    map("i", "<A-d>", actions.git_delete_branch)
    map("n", "d", actions.git_delete_branch)
    return true
  end

  if utils.os.in_bare and not utils.os.in_worktree then
    opts.attach_mappings = function(_, map)
      map("i", "<A-d>", require("telescope").extensions.git_worktree.actions.delete_worktree)
      map("n", "d", require("telescope").extensions.git_worktree.actions.delete_worktree)
      return true
    end
    require("telescope").extensions.git_worktree.git_worktrees(opts)
  elseif utils.os.in_worktree and not utils.os.in_bare then
    opts.prompt_title = "Git Branches"
    require("telescope.builtin").git_branches(opts)
  else
    vim.notify(
      "[telescope] Not in a git repository. Unable to pull up any branches info.",
      vim.log.levels.WARN
    )
  end
end

M.create_git_worktree = function()
  local opts = themes.get_dropdown({
    layout_config = {
      width = 70,
      height = 40,
    },
    layout_strategy = "vertical",
  })

  if utils.os.in_bare and not utils.os.in_worktree then
    opts.prompt_title = "Create Worktree"
    require("telescope").extensions.git_worktree.create_git_worktree(opts)
  else
    vim.notify("[telescope] Not in a git worktree repository.", vim.log.levels.WARN)
  end
end

M.lsp_code_actions = function()
  local opts = themes.get_cursor({
    previewer = false,
  })
  require("telescope.builtin").lsp_code_actions(opts)
end

M.neoclip = function()
  local opts = themes.get_ivy()
  require("telescope").extensions.neoclip.default(opts)
end

M.treesitter_symbols = function(opts)
  opts = opts or themes.get_ivy({
    -- symbols = { "function", "object", "constant" },
  })
  require("telescope.builtin").treesitter(opts)
end

M.lsp_document_symbols = function(opts)
  opts = opts or themes.get_ivy({
    symbols = { "function", "object", "constant" },
  })
  require("telescope.builtin").lsp_document_symbols(opts)
end

M.lsp_workspace_symbols = function(opts)
  opts = opts or themes.get_ivy()
  require("telescope.builtin").lsp_workspace_symbols(opts)
end

M.curbuf = function(opts)
  opts = opts
    or themes.get_dropdown({
      previewer = false,
      shorten_path = false,
      border = true,
    })
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

M.git_hunks = function(opts)
  local gs_cache = require("gitsigns.cache")
  local buf_cache = gs_cache.cache[vim.api.nvim_get_current_buf()]
  if not buf_cache then
    vim.notify("[jtelescope] Gitsigns buf_cache is empty", vim.log.levels.WARN)
    return
  end

  local function get_hunk_lnum_text(hunk_data)
    local hunk_type_name
    if hunk_data.type == "delete" then
      hunk_type_name = "removed"
    else
      hunk_type_name = "added"
    end
    local hunk_specifics = hunk_data[hunk_type_name]
    return string.gsub(hunk_specifics.lines[1] or "", "^%s+", ""), hunk_specifics.start
  end

  local hunks = {}
  for _, hunk_data in pairs(buf_cache.hunks) do
    local text, lnum = get_hunk_lnum_text(hunk_data)
    local hunk = {
      lnum = lnum,
      head = hunk_data.head,
      text = text,
      type = hunk_data.type,
      bufnr = vim.api.nvim_get_current_buf(),
      filename = vim.api.nvim_buf_get_name(0),
    }
    table.insert(hunks, hunk)
  end

  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Git Hunks",
      finder = finders.new_table({
        results = hunks,
        entry_maker = tele_utils.git_hunks_entry(opts),
      }),
      previewer = config.values.qflist_previewer(opts),
      sorter = config.values.generic_sorter(opts),
    })
    :find()
end

M.lsp_reference = function(opts)
  opts = opts or {}
  opts.layout_strategy = "vertical"
  -- opts.entry_maker = tele_utils.lsp_ref_entry(opts)
  require("telescope.builtin").lsp_references(opts)
end

M.lsp_definition = function(opts)
  opts = opts or {}
  opts.layout_strategy = "vertical"
  -- opts.entry_maker = tele_utils.lsp_ref_entry(opts)
  require("telescope.builtin").lsp_definitions(opts)
end

local treesitter_type_highlight = {
  ["associated"] = "@constant",
  ["constant"] = "@constant",
  ["enum"] = "@type",
  ["field"] = "@property",
  ["function"] = "@function",
  ["import"] = "@module",
  ["label"] = "@label",
  ["macro"] = "@function.macro",
  ["method"] = "@function.method",
  ["namespace"] = "@module",
  ["parameter"] = "@variable.parameter",
  ["property"] = "@property",
  ["var"] = "@variable",
  ["variable"] = "@variable",
}

local ts_kinds = {
  ["associated"] = "",
  ["constant"] = "",
  ["enum"] = "",
  ["field"] = "",
  ["function"] = "",
  ["import"] = "",
  ["label"] = "",
  ["macro"] = "",
  ["method"] = "",
  ["namespace"] = "",
  ["parameter"] = "",
  ["property"] = "",
  ["var"] = "",
  ["variable"] = "",
}

local ALLOWED_KINDS = {
  "constant",
  "enum",
  "function",
  "method",
  "macro",
  "var",
  "variable",
}

local function prepare_match(entry)
  local entries = {}

  if entry.node then
    if vim.tbl_contains(ALLOWED_KINDS, entry.kind) then table.insert(entries, entry) end
  else
    for _, item in pairs(entry) do
      vim.list_extend(entries, prepare_match(item))
    end
  end

  return entries
end

local function gen_from_treesitter(opts)
  opts = opts or {}

  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  local display_items = {
    { width = 2 },
    { remaining = true },
  }

  local displayer = entry_display.create({
    separator = " ",
    items = display_items,
  })

  local make_display = function(entry)
    local display_columns = {
      {
        ts_kinds[entry.kind],
        treesitter_type_highlight[entry.kind],
        treesitter_type_highlight[entry.kind],
      },
      entry.text,
    }

    return displayer(display_columns)
  end

  return function(entry)
    local start_row, start_col, end_row, _ = vim.treesitter.get_node_range(entry.node)
    local node_text = vim.treesitter.get_node_text(entry.node, bufnr)
    return make_entry.set_default_entry_mt({
      value = entry.node,
      kind = entry.kind,
      ordinal = node_text .. " " .. (entry.kind or "unknown"),
      display = make_display,

      node_text = node_text,

      filename = filename,
      -- need to add one since the previewer substacts one
      lnum = start_row + 1,
      col = start_col,
      text = node_text,
      start = start_row,
      finish = end_row,
    }, opts)
  end
end

M.symbols = function(opts)
  opts = opts or {}
  opts.bufnr = vim.F.if_nil(opts.bufnr, vim.api.nvim_get_current_buf())
  opts.winnr = vim.F.if_nil(opts.winnr, vim.api.nvim_get_current_win())
  local original_pos = vim.api.nvim_win_get_cursor(opts.winnr)

  local parsers = require("nvim-treesitter.parsers")
  if not parsers.has_parser(parsers.get_buf_lang(opts.bufnr)) then
    vim.notify("No parser for the current buffer", vim.log.levels.ERROR)
    return
  end

  local ts_locals = require("nvim-treesitter.locals")
  local results = {}
  for _, definition in ipairs(ts_locals.get_definitions(opts.bufnr)) do
    local entries = prepare_match(ts_locals.get_local_nodes(definition))
    for _, entry in ipairs(entries) do
      entry.kind = vim.F.if_nil(entry.kind, "")
      table.insert(results, entry)
    end
  end

  if vim.tbl_isempty(results) then return end

  opts.layout_config = {
    anchor = "N",
    height = 12,
    width = 50,
  }
  opts = themes.get_dropdown(opts)

  local function set_pos(original)
    if original then
      vim.api.nvim_win_set_cursor(opts.winnr, original_pos)
    else
      local entry = action_state.get_selected_entry()
      vim.api.nvim_win_set_cursor(opts.winnr, { entry.lnum, entry.col })
    end
  end

  pickers
    .new(opts, {
      prompt_title = "Treesitter Symbols",
      finder = finders.new_table({
        results = results,
        entry_maker = gen_from_treesitter(opts),
      }),
      attach_mappings = function()
        action_set.shift_selection:enhance({ post = function() set_pos(false) end })
        actions.close:enhance({ post = function() set_pos(true) end })
        return true
      end,
      on_complete = {
        function() set_pos(false) end,
      },
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

---@param current_path boolean?
---@return fun() # telescope picker
M.file_browser = function(current_path)
  local opts = {}
  if current_path then opts = { path = "%:p:h", select_buffer = true } end
  return function()
    require("telescope").extensions.file_browser.file_browser(opts)
  end
end

return M
