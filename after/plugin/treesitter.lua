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
  "json",
  "latex",
  "lua",
  "make",
  "perl",
  "php",
  "python",
  "rust",
  "tsx",
  "yaml",
}

ts_config.setup({
  ensure_installed = not Work and ensure_installed or nil,
  highlight = {
    enable = true,
    use_languagetree = true,
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
})

