local ts_config = require("nvim-treesitter.configs")
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

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
  "regex",
}

ts_config.setup({
  ensure_installed = not Work and ensure_installed or nil,
  highlight = {
    enable = true,
    use_languagetree = true,
    -- disable = { "help" },
  },
  matchup = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "python", "c", "cpp" },
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
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

-- monkey ts setup
parser_config.monkey = {
  install_info = {
    url = "~/projects/archive/tree-sitter-monkey", -- local path or git repo
    files = { "src/parser.c" },
    -- optional entries:
    branch = "master", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "mon", -- if filetype does not match the parser name
}
