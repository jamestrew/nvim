local M = {
  "nvim-telescope/telescope.nvim",
  dir = "/home/jt/projects/telescope.nvim",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "stevearc/dressing.nvim" },
    {
      "AckslD/nvim-neoclip.lua",
      opts = {
        default_register = "+",
        enable_persistent_history = true,
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
      },
      dependencies = {
        { "kkharji/sqlite.lua" },
      },
    },
    { "ibhagwan/fzf-lua", cmd = "FzfLua" },
    { "debugloop/telescope-undo.nvim" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dir = "/home/jt/projects/telescope-file-browser.nvim/master",
      -- dir = "/home/jt/projects/telescope-file-browser.nvim/filename-first",
      name = "telescope-file-browser.nvim",
    },
    { "jonarrien/telescope-cmdline.nvim" },
  },
  cmd = "Telescope",
}

M.keys = function()
  local builtin = require("telescope.builtin")
  local jtelescope = require("plugins.telescope.pickers")
  return {
    { "<leader>fw", jtelescope.live_grep, silent = true },
    { "<leader>gc", builtin.git_commits, silent = true },
    { "<leader>fb", jtelescope.buffers, silent = true },
    { "<leader>fh", builtin.help_tags, silent = true },
    { "<leader>gw", builtin.grep_string, silent = true, mode = { "n", "v", "x" } },
    { "<leader>fc", ":Telescope cmdline<CR>", silent = true },
    { "<leader>fs", jtelescope.symbols, silent = true },
    { "<leader>rc", jtelescope.search_dotfiles },
    { "<leader>fg", jtelescope.git_worktrees },
    { "<leader>ct", jtelescope.create_git_worktree },
    { "<leader>fy", jtelescope.neoclip },
    { "<leader>ff", jtelescope.curbuf },
    { "<leader>gh", jtelescope.git_hunks },
    { "<C-p>", jtelescope.project_files },
    { "<C-e>", jtelescope.file_browser() },
    { "<leader><C-e>", jtelescope.file_browser(true) },
    { "<leader>rl", builtin.reloader, silent = true },
    { "<leader>fo", builtin.vim_options, silent = true },
    { "<leader>gc",  builtin.git_bcommits_range, mode = { "v", "x" } },
  }
end

M.config = function()
  local actions = require("telescope.actions")
  local action_layout = require("telescope.actions.layout")
  local builtin = require("telescope.builtin")
  local jtelescope = require("plugins.telescope.pickers")

  local tele_utils = require("plugins.telescope.utils")
  local fb_actions = require("telescope._extensions.file_browser.actions")

  local set_width = function(_, cols, _)
    if cols > 200 then
      return 170
    else
      return math.floor(cols * 0.87)
    end
  end

  local ok, TSLayout = pcall(require, "telescope.pickers.layout")
  local fused_layout = nil
  if ok then fused_layout = tele_utils.create_fused_layout(TSLayout) end

  require("telescope").setup({
    defaults = {
      -- path_display = { "filename_first" },
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
          preview_cutoff = 120,
          width = set_width,
        },
        vertical = {
          mirror = false,
          height = 0.9,
          preview_height = 0.8,
          width = 120,
        },
        height = 0.80,
      },
      winblend = 0,
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
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
          ["<C-t>"] = actions.toggle_all,
          ["<M-s>"] = tele_utils.diffsplit,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
        },
        n = {
          ["<C-p>"] = actions.move_selection_better,
          ["<C-n>"] = actions.move_selection_worse,
          ["<M-p>"] = action_layout.toggle_preview,
          ["<C-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
        },
      },
    },
    pickers = {
      find_files = {
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            size = {
              width = "80%",
              height = "80%",
            },
          },
          vertical = {
            size = {
              width = "90%",
              height = "90%",
            },
          },
          flex = {
            flip_columns = 120,
          },
        },
        create_layout = fused_layout,
        mappings = {
          i = { ["<M-p>"] = tele_utils.toggle_tiny_layout },
        },
      },
      git_commits = {
        mappings = {
          i = {
            ["<C-h>"] = actions.cycle_previewers_next,
            ["<C-l>"] = actions.cycle_previewers_prev,
          },
        },
        -- previewer = require("telescope.previewers").new_termopen_previewer({
        --   get_command = function(entry)
        --     return {
        --       "git",
        --       "-c",
        --       "core.pager=delta",
        --       "-c",
        --       "delta.side-by-side=false",
        --       "diff",
        --       entry.value .. "^!",
        --     }
        --   end,
        -- }),
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
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg" },
        find_cmd = "rg", -- find command (defaults to `fd`)
      },
      file_browser = {
        theme = "ivy",
        hijack_netrw = false,
        hidden = { file_browser = true, folder_browser = false },
        grouped = true,
        hide_parent_dir = true,
        quiet = false,
        respect_gitignore = false,
        git_status = true,
        show_symlinks = true,
        follow_symlinks = true,
        mappings = {
          i = {
            ["<A-n>"] = fb_actions.select_all,
            ["<A-f>"] = tele_utils.open_using(jtelescope.project_files),
            ["<A-g>"] = tele_utils.open_using(jtelescope.live_grep),
            ["<C-s>"] = fb_actions.sort_by_date,
            ["<C-e>"] = tele_utils.current_bufr_dir,
            ["<C-w>"] = { "<c-s-w>", type = "command" },
            ["<C-r>"] = fb_actions.toggle_respect_gitignore,
          },
          n = {
            ["<A-f>"] = tele_utils.open_using(builtin.find_files),
            ["<A-g>"] = tele_utils.open_using(builtin.live_grep),
            ["s"] = fb_actions.sort_by_date,
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
      undo = {
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },
        mappings = {
          i = {
            ["<cr>"] = require("telescope-undo.actions").yank_additions,
            ["<C-y>"] = require("telescope-undo.actions").yank_deletions,
            ["<C-r>"] = require("telescope-undo.actions").restore,
          },
        },
      },
    },
  })
end

return M
