local ts_config = require("nvim-treesitter.configs")

local ensure_installed = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "graphql",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "make",
  "python",
  "query",
  "rust",
  "scss",
  "sql",
  "tsx",
  "typescript",
  "vim",
  "yaml",
  "markdown",
}

ts_config.setup({
  ensure_installed = not Work and ensure_installed or nil,
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = { "help" },
  },
  matchup = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python", "c", "lua", "cpp" },
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  context_commentstring = {
    enable = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  textobjects = {
    select = {
      enable = false,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>SA"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]]"] = "@function.outer",
        ["))"] = "@class.outer",
      },
      goto_next_end = {
        ["])"] = "@function.outer",
        [")}"] = "@class.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["(("] = "@class.outer",
      },
      goto_previous_end = {
        ["[("] = "@function.outer",
        ["({"] = "@class.outer",
      },
    },
  },
})
