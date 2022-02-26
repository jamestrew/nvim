local utils = require("utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local config = require("telescope.config")

local tele_utils = require("jtelescope.utils")

local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").git_files({
    prompt_title = "< VimRC >",
    cwd = "~/.config/nvim/",
  })
end

M.find_files = function(opts)
  local use_frecency = false

  opts = opts or {}
  opts.cwd = opts.cwd or vim.loop.cwd()
  -- TODO: match mapping with file_browser (in fact maybe use it's actions)
  opts.attach_mappings = function(_, map)
    map("i", "<A-d>", tele_utils.delete_file)
    map("i", "<A-r>", tele_utils.rename_file)
    map("i", "<A-y>", tele_utils.yank_fpath)
    map("n", "yy", tele_utils.yank_fpath)

    return true
  end

  if use_frecency then
    opts.default_text = ":CWD:"
    require("telescope").extensions.frecency.frecency(opts)
    return
  end

  if not utils.os.in_worktree and not utils.os.in_bare then
    require("telescope.builtin").find_files(opts)
  else
    require("telescope.builtin").git_files(opts)
  end
end

M.git_worktrees = function()
  local opts = themes.get_dropdown({
    -- previewer = false,
    path_display = { "shorten" },
    layout_config = {
      width = 70,
      height = 20,
    },
    -- layout_strategy = "vertical",
  })
  opts.attach_mappings = function(_, map)
    map("i", "<A-c>", actions.git_create_branch)
    map("n", "c", actions.git_create_branch)
    map("i", "<A-d>", actions.git_delete_branch)
    map("n", "d", actions.git_delete_branch)
    return tele_utils.alt_scroll(map)
  end

  if utils.os.in_bare and not utils.os.in_worktree then
    opts.widths = {
      path = false,
      branch = 50,
      sha = 7,
    }
    opts.prompt_title = "Git Worktrees"
    opts.attach_mappings = function(prompt_bufnr, _)
      local switch_and_find = function()
        local worktree_path = action_state.get_selected_entry().path
        actions.close(prompt_bufnr)
        if worktree_path ~= nil then
          require("git-worktree").switch_worktree(worktree_path)
        end
      end
      actions.select_default:replace(switch_and_find)
      return true
    end
    require("telescope").extensions.git_worktree.git_worktrees(opts)
  elseif utils.os.in_worktree and not utils.os.in_bare then
    opts.prompt_title = "Git Branches"
    require("telescope.builtin").git_branches(opts)
  else
    vim.notify("[telescope] Not in a git repository. Unable to pull up any branches info.", vim.log.levels.WARN)
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

  opts.attach_mappings = function(_, map)
    return tele_utils.alt_scroll(map)
  end

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
  opts.attach_mappings = function(_, map)
    return tele_utils.alt_scroll(map)
  end
  require("telescope.builtin").lsp_code_actions(opts)
end

M.refactor = function()
  local refactoring = require("refactoring")
  local function refactor(prompt_bufnr)
    local content = action_state.get_selected_entry()
    actions.close(prompt_bufnr)
    refactoring.refactor(content.value)
  end
  local opts = themes.get_cursor()
  opts.attach_mappings = function(_, map)
    return tele_utils.alt_scroll(map)
  end

  pickers.new(opts, {
    prompt_title = "REFACTOR",
    finder = finders.new_table({
      results = refactoring.get_refactors(),
    }),
    sorter = config.values.generic_sorter(opts),
    attach_mappings = function(_, map)
      map("i", "<CR>", refactor)
      map("n", "<CR>", refactor)
      return true
    end,
  }):find()
end

M.neoclip = function()
  local opts = themes.get_ivy()
  opts.attach_mappings = function(_, map)
    return tele_utils.alt_scroll(map)
  end
  require("telescope").extensions.neoclip.default(opts)
end

M.get_symbols = function(opts)
  opts = opts or themes.get_ivy()

  opts.attach_mappings = function(_, map)
    return tele_utils.alt_scroll(map)
  end

  local ts_healthy = true
  for _, definitions in ipairs(require("nvim-treesitter.locals").get_definitions()) do
    if definitions["node"] ~= nil then
      ts_healthy = false
      break
    end
  end

  -- if vim.bo.filetype == "lua" then
  --   require("telescope.builtin").lsp_document_symbols(opts)
  if ts_healthy then
    require("telescope.builtin").treesitter(opts)
  else
    print("[jtelescope] error exists in treesitter nodes - using lsp instead")
    require("telescope.builtin").lsp_document_symbols(opts)
  end
end
M.curbuf = function(opts)
  opts = opts or themes.get_dropdown({
    previewer = false,
    shorten_path = false,
    border = true,
  })
  opts.attach_mappings = function(_, map)
    return tele_utils.alt_scroll(map)
  end
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

M.file_browser = function(opts)
  opts = opts or {}
  opts.attach_mappings = function(_, map)
    return tele_utils.alt_scroll(map)
  end
  require("telescope").extensions.file_browser.file_browser(opts)
end

M.git_hunks = function(opts)
  local gs_cache = require("gitsigns.cache")
  local buf_cache = gs_cache.cache[vim.api.nvim_get_current_buf()]
  if not buf_cache then
    vim.notify("[jtelescope] Gitsigns buf_cache is empty", vim.log.levels.WARN)
    return
  end

  local function get_hunk_text(hunk_data)
    local hunk_field
    if hunk_data.type == "delete" then
      hunk_field = "removed"
    else
      hunk_field = "added"
    end
    return string.gsub(hunk_data[hunk_field].lines[1] or "", "^%s+", "")
  end

  local hunks = {}
  for _, hunk_data in pairs(buf_cache.hunks) do
    local hunk = {
      lnum = hunk_data.start,
      head = hunk_data.head,
      text = get_hunk_text(hunk_data),
      type = hunk_data.type,
      bufnr = vim.api.nvim_get_current_buf(),
      filename = vim.api.nvim_buf_get_name(0)
    }
    table.insert(hunks, hunk)
  end

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Git Hunks",
    finder = finders.new_table({ results = hunks, entry_maker = tele_utils.git_hunks_entry(opts) }),
    previewer = config.values.qflist_previewer(opts),
    sorter = config.values.generic_sorter(opts),
  }):find()
end

return M
