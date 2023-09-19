local utils = require("utils")
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config")

local tele_utils = require("plugins.telescope.utils")

local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").git_files({
    prompt_title = "< Nvim >",
    cwd = "~/.config/nvim/",
  })
end

M.project_files = function(opts, find_files)
  opts = opts or {}
  find_files = vim.F.if_nil(find_files, false)
  opts.attach_mappings = function(_, map)
    map("i", "<A-d>", tele_utils.delete_file)
    map("i", "<A-r>", tele_utils.rename_file)
    map("i", "<A-y>", tele_utils.yank_fpath)
    map("i", "<C-f>", tele_utils.toggle_files)
    map("i", "<A-s>", tele_utils.diffsplit)
    map("n", "yy", tele_utils.yank_fpath)
    map("n", "<C-f>", tele_utils.toggle_files)
    return true
  end

  if find_files then
    opts.no_ignore = true
    opts.prompt_title = "Find Files"
    require("telescope.builtin").find_files(opts)
  else
    opts.prompt_title = "Git Files"
    require("telescope.builtin").find_files(opts)
  end
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

M.lsp_document_symbols = function(opts)
  opts = opts or themes.get_ivy()
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

M.live_grep_file = function(opts)
  opts = opts
    or themes.get_dropdown({
      previewer = false,
      shorten_path = false,
      border = true,
      prompt_title = "Grep File",
      search_dirs = { vim.fn.expand("%:p") },
    })
  require("telescope.builtin").live_grep(opts)
end

return M
