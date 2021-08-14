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
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_previous,
          ["<C-p>"] = actions.move_selection_next,
        },
      },
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
    },
  }

  require("telescope").load_extension "fzf"
  require("telescope").load_extension "media_files"
  require("telescope").load_extension "git_worktree"
  require("telescope").load_extension "project"
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
  opts = opts or {}
  opts.attach_mappings = function(_, map)
    map("i", "<C-y>d", delete_file)
    map("i", "<C-y>r", rename_file)
    map("i", "<C-y>y", yank_fpath)
    map("n", "yy", yank_fpath)

    return true
  end

  if utils.os.is_git_dir == "O" then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
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

return M
