local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "nvim-treesitter/nvim-treesitter-context", config = true },
    { "andymass/vim-matchup" },
  },
  build = ":TSUpdate",
  event = { "VeryLazy" },
}

local ensure_installed = {
  "bash",
  "cpp",
  "css",
  "go",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "luadoc",
  "make",
  "python",
  "query",
  "rust",
  "sql",
  "tsx",
  "typescript",
  "vim",
  "yaml",
  "toml",
  "regex",
}

local opts = {
  ensure_installed = ensure_installed,
  highlight = {
    enable = true,
    disable = function(_lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then return true end
    end,
  },
  matchup = {
    enable = true,
  },
  indent = {
    enable = true,
    -- disable = { "lua", "c", "cpp" },
  },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnn",
      scope_incremental = "grc",
      node_decremental = "grm",
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
