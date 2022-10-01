local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local tele_utils = require("jtelescope.utils")
local builtin = require("telescope.builtin")

require("telescope").setup({
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
      width = function(_, cols, _)
        if cols > 200 then
          return 170
        else
          return math.floor(cols * 0.87)
        end
      end,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = sorters.get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    -- path_display = { "smart" },
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
    -- cycle_layout_list = tele_utils.cycle_layouts,
    mappings = {
      i = {
        ["<C-p>"] = actions.move_selection_better,
        ["<C-n>"] = actions.move_selection_worse,
        ["<Esc>"] = actions.close,
        ["<C-c>"] = false,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-l>"] = action_layout.cycle_layout_next,
      },
      n = {
        ["<C-p>"] = actions.move_selection_better,
        ["<C-n>"] = actions.move_selection_worse,
        ["<M-p>"] = action_layout.toggle_preview,
      },
    },
  },
  extensions = {
    git_worktree = {
      path_display = { "shorten" },
      layout_config = {
        width = 70,
        height = 20,
      },
      ordinal_key = "path",
      items = {
        { "path", 57 },
        { "sha", 7 },
      },
    },
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
    file_browser = {
      theme = "ivy",
      hijack_netrw = false,
      files = true,
      hidden = true,
      grouped = true,
      hide_parent_dir = true,
      quiet = true,
      respect_gitignore = false,
      mappings = {
        i = {
          ["<C-b>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
          ["<A-n>"] = require("telescope._extensions.file_browser.actions").select_all,
          ["<A-f>"] = tele_utils.open_using(builtin.find_files),
          ["<A-g>"] = tele_utils.open_using(builtin.live_grep),
          ["<A-a>"] = require("harpoon.browser").add_folder,
          ["<C-s>"] = require("telescope._extensions.file_browser.actions").sort_by_date,
        },
        n = {
          ["<A-f>"] = tele_utils.open_using(builtin.find_files),
          ["<A-g>"] = tele_utils.open_using(builtin.live_grep),
          ["<C-b>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
          ["<A-a>"] = require("harpoon.browser").add_folder,
          ["s"] = require("telescope._extensions.file_browser.actions").sort_by_date,
        },
      },
    },
    live_grep_args = {
      auto_quoting = false,
      mappings = {
        i = {
          ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
          ["<C-t>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -t" }),
        },
        n = {
          ["k"] = require("telescope-live-grep-args.actions").quote_prompt(),
          ["t"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -t" }),
        },
      },
    },
  },
})

require("neoclip").setup({
  default_register = "+",
  keys = {
    paste = "<C-y>p",
    paste_behind = "<C-y>P",
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("live_grep_args")
