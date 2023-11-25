local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "nvim-treesitter/nvim-treesitter-context", config = true },
    { "yioneko/nvim-yati" },
  },
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
}

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
  "toml",
  "markdown",
  "regex",
  "vimdoc",
}

local opts = {
  ensure_installed = ensure_installed,
  highlight = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "lua", "c", "cpp" },
  },
  autotag = {
    enable = true,
  },
  yati = {
    enable = false, -- should no longer be necessary
    default_lazy = true,
    default_fallback = "auto",
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
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
}

M.config = function() require("nvim-treesitter.configs").setup(opts) end

return M
