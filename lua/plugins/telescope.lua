local utils = require("utils")
local l = require("mappings").l
local nnoremap = utils.nnoremap

local telescope = function()
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
          ["<C-s>"] = actions.select_horizontal,
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
        auto_depth = 2,
        git_status = true,
        mappings = {
          i = {
            ["<C-b>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
            ["<A-n>"] = require("telescope._extensions.file_browser.actions").select_all,
            ["<A-f>"] = tele_utils.open_using(builtin.find_files),
            ["<A-g>"] = tele_utils.open_using(builtin.live_grep),
            ["<C-s>"] = require("telescope._extensions.file_browser.actions").sort_by_date,
            ["<C-y>c"] = require("telescope._extensions.file_browser.actions").create,
            ["<C-y><C-c>"] = require("telescope._extensions.file_browser.actions").create,
            ["<C-y>r"] = require("telescope._extensions.file_browser.actions").rename,
            ["<C-y><C-r>"] = require("telescope._extensions.file_browser.actions").rename,
            ["<C-y>d"] = require("telescope._extensions.file_browser.actions").remove,
            ["<C-y><C-d>"] = require("telescope._extensions.file_browser.actions").remove,
            ["<C-y>p"] = require("telescope._extensions.file_browser.actions").move,
            ["<C-y><C-p>"] = require("telescope._extensions.file_browser.actions").move,
            ["<C-y>y"] = require("telescope._extensions.file_browser.actions").copy,
            ["<C-y><C-y>"] = require("telescope._extensions.file_browser.actions").copy,
          },
          n = {
            ["<A-f>"] = tele_utils.open_using(builtin.find_files),
            ["<A-g>"] = tele_utils.open_using(builtin.live_grep),
            ["<C-b>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
            ["s"] = require("telescope._extensions.file_browser.actions").sort_by_date,
          },
        },
      },
      live_grep_args = {
        auto_quoting = false,
        mappings = {
          i = {
            ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
            ["<C-t>"] = require("telescope-live-grep-args.actions").quote_prompt({
              postfix = " -t",
            }),
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
    enable_persistent_history = not Work,
    keys = {
      telescope = {
        i = {
          select = "<cr>",
          paste = "<c-y>p",
          paste_behind = "<c-y>P",
          replay = "<c-q>", -- replay a macro
          delete = "<c-d>", -- delete an entry
          custom = {},
        },
        n = {
          select = "<cr>",
          paste = "p",
          paste_behind = "P",
          replay = "q",
          delete = "d",
          custom = {},
        },
      },
    },
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("git_worktree")
  require("telescope").load_extension("neoclip")
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("live_grep_args")
  require("telescope").load_extension("undo")

  local silent = { silent = true }
  local telescope = require("telescope.builtin")
  local tele_ext = require("telescope").extensions
  local jtelescope = require("jtelescope")
  nnoremap("<C-p>", jtelescope.project_files)
  nnoremap(l("<C-p>"), function() jtelescope.project_files({}, true) end)
  nnoremap("<C-e>", tele_ext.file_browser.file_browser, silent)
  nnoremap(
    l("<C-e>"),
    function() tele_ext.file_browser.file_browser({ path = "%:p:h", select_buffer = true }) end,
    silent
  )
  nnoremap(l("fw"), telescope.live_grep, silent)
  nnoremap(l(l("fw")), tele_ext.live_grep_args.live_grep_args, silent)
  nnoremap(l("gf"), jtelescope.live_grep_file, silent)
  nnoremap(l("gc"), telescope.git_commits, silent)
  nnoremap(l("fb"), telescope.buffers, silent)
  nnoremap(l("fh"), telescope.help_tags, silent)
  nnoremap(l("gw"), telescope.grep_string, silent)
  nnoremap(l("rc"), jtelescope.search_dotfiles, silent)
  nnoremap(l("fg"), jtelescope.git_worktrees, silent)
  nnoremap(l("ct"), jtelescope.create_git_worktree, silent)
  nnoremap(l("fy"), jtelescope.neoclip, silent)
  nnoremap(l("ff"), jtelescope.curbuf, silent)
  nnoremap(l("fc"), telescope.commands, silent)
  nnoremap(l("gh"), jtelescope.git_hunks, silent)
  nnoremap(l("vrc"), jtelescope.search_dotfiles, silent)
  nnoremap(l(l("u")), tele_ext.undo.undo)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    config = telescope,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "debugloop/telescope-undo.nvim" },
  {
    "AckslD/nvim-neoclip.lua",
    config = true,
    dependencies = {
      { "kkharji/sqlite.lua", enable = not Work },
    },
  },
}
