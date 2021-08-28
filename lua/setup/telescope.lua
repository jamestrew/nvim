local utils = require "utils"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local config = require "telescope.config"
local Path = require "plenary.path"

local M = {}

M.config = function()
  require("telescope").setup {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "  ",
      selection_caret = " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = sorters.get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = sorters.get_generic_fuzzy_sorter,
      path_display = { "smart" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = false, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg" },
        find_cmd = "rg", -- find command (defaults to `fd`)
      },
      frecency = {
        ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
      },
    },
  }

  require("telescope").load_extension "fzf"
  require("telescope").load_extension "media_files"
  require("telescope").load_extension "git_worktree"
  require("telescope").load_extension "project"
  require("telescope").load_extension "neoclip"
  -- require("telescope").load_extension "frecency"
end

local delete_file = function(prompt_bufnr)
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

local rename_file = function()
  local fpath = action_state.get_selected_entry().value
  local new_name = vim.fn.input("Rename ", fpath)
  utils.clear_prompt()
  Path:new(fpath):rename { new_name = new_name }
end

local create_file = function(prompt_bufnr)
  local fpath = action_state.get_selected_entry().value
  local new_file = vim.fn.input("Create file: ", fpath .. "/")
  utils.clear_prompt()

  if not utils.is_dir(new_file) then
    actions.close(prompt_bufnr)
    Path:new(new_file):touch { parents = true }
    vim.cmd(string.format(":e %s", new_file))
  else
    print "Given path not a valid file name"
  end
end

local yank_fpath = function()
  local entry = action_state.get_selected_entry()
  vim.fn.setreg("+", entry.value)
end

M.search_dotfiles = function()
  require("telescope.builtin").git_files {
    prompt_title = "< VimRC >",
    cwd = "~/.config/nvim/",
  }
end

M.find_files = function(opts)
  local use_frecency = false

  opts = opts or {}
  opts.cwd = opts.cwd or vim.loop.cwd()
  opts.attach_mappings = function(_, map)
    map("i", "<C-n>", actions.move_selection_previous)
    map("i", "<C-p>", actions.move_selection_next)
    map("i", "<C-y>d", delete_file)
    map("i", "<C-y>r", rename_file)
    map("i", "<C-y>y", yank_fpath)
    map("n", "yy", yank_fpath)

    return true
  end

  if use_frecency then
    opts.default_text = ":CWD:"
    require("telescope").extensions.frecency.frecency(opts)
    return
  end

  if utils.is_git_dir() then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

M.find_dir = function()
  local opts = themes.get_ivy {
    cwd = vim.loop.cwd(),
    find_command = { "fd", "--type", "d" },
    disable_devicons = true,
  }

  opts.entry_maker = require("telescope.make_entry").gen_from_file(opts)
  opts.attach_mappings = function(prompt_bufnr, map)
    map("i", "<C-y>c", create_file)
    map("i", "<C-h>", function()
      actions.close(prompt_bufnr)
      vim.cmd ":Ntree"
    end)
    return true
  end

  pickers.new(opts, {
    prompt_title = "Find Directory",
    finder = finders.new_oneshot_job(opts.find_command, opts),
    previewer = config.values.file_previewer(opts),
    sorter = config.values.file_sorter(opts),
  }):find()
end

M.projects = function()
  local opts = themes.get_dropdown {
    previewer = false,
    winblend = 5,
    layout_config = {
      width = 50,
      height = 20,
    },
  }
  opts.attach_mappings = function(prompt_bufnr, _)
    local on_project_selected = function()
      local project_path = actions.get_selected_entry(prompt_bufnr).value
      actions.close(prompt_bufnr)
      local cd_successful = utils.change_project_dir(project_path)
      if cd_successful then
        M.git_worktrees()
      end
    end

    actions.select_default:replace(on_project_selected)
    return true
  end
  require("telescope").extensions.project.project(opts)
end

M.git_worktrees = function()
  local opts = themes.get_dropdown {
    previewer = false,
    winblend = 10,
    path_display = { "shorten" },
    layout_config = {
      width = 60,
      height = 20,
    },
  }

  opts.attach_mappings = function(prompt_bufnr, _)
    local switch_and_find = function()
      local worktree_path = action_state.get_selected_entry(prompt_bufnr).path
      actions.close(prompt_bufnr)
      if worktree_path ~= nil then
        require("git-worktree").switch_worktree(worktree_path)
      end
    end

    actions.select_default:replace(switch_and_find)
    return true
  end
  require("telescope").extensions.git_worktree.git_worktrees(opts)
end

M.create_git_worktree = function()
  local opts = themes.get_dropdown {
    winblend = 5,
    layout_config = {
      width = 70,
      height = 40,
    },
    layout_strategy = "vertical",
  }
  require("telescope").extensions.git_worktree.create_git_worktree(opts)
end

M.file_browser = function()
  require("telescope.builtin").file_browser {
    attach_mappings = function(_, map)
      map("i", "<C-y>d", delete_file)
      map("i", "<C-y>r", rename_file)
      map("i", "<C-y>y", yank_fpath)
      map("n", "yy", yank_fpath)

      return true
    end,
  }
end

M.lsp_code_actions = function()
  local opts = themes.get_cursor {
    previewer = false,
  }
  require("telescope.builtin").lsp_code_actions(opts)
end

M.refactor = function()
  local refactoring = require "refactoring"
  local function refactor(prompt_bufnr)
    local content = action_state.get_selected_entry(prompt_bufnr)
    actions.close(prompt_bufnr)
    refactoring.refactor(content.value)
  end
  local opts = themes.get_cursor()

  pickers.new(opts, {
    prompt_title = "REFACTOR",
    finder = finders.new_table {
      results = refactoring.get_refactors(),
    },
    sorter = config.values.generic_sorter(opts),
    attach_mappings = function(_, map)
      map("i", "<CR>", refactor)
      map("n", "<CR>", refactor)
      return true
    end,
  }):find()
end

M.neoclip = function()
  require("telescope").extensions.neoclip.default(themes.get_cursor())
end

M.get_symbols = function(opts)
  opts = opts or themes.get_ivy()
  local ts_healthy = true
  for _, definitions in ipairs(require("nvim-treesitter.locals").get_definitions()) do
    if definitions["node"] ~= nil then
      ts_healthy = false
      break
    end
  end

  if ts_healthy then
    require("telescope.builtin").treesitter(opts)
  else
    require("telescope.builtin").lsp_document_symbols(opts)
  end
end

return M
