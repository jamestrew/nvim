return {
  {
    "dmtrKovalenko/fff.nvim",
    build = "nix run .#release",
    opts = {
      keymaps = {
        move_up = { "<Up>", "<C-n>" },
        move_down = { "<Down>", "<C-p>" },
      },
      hl = {
        matched = "",
      },
      prompt = "➤ ",
    },
    keys = {
      {
        "<C-p>", -- try it if you didn't it is a banger keybinding for a picker
        function() require("fff").find_files() end,
        desc = "Toggle FFF",
      },
    },
  },
  { "mbbill/undotree" },
  { "samjwill/nvim-unception" },
  {
    "codethread/qmk.nvim",
    opts = {
      name = "LAYOUT_manuform_num",
      layout = {
        "x x x x x x _ _ _ _ _ x x x x x x",
        "x x x x x x _ _ _ _ _ x x x x x x",
        "x x x x x x _ _ _ _ _ x x x x x x",
        "x x x x x x _ _ _ _ _ x x x x x x",
        "x x x x x x x _ _ _ x x x x x x x",
        "_ _ _ _ x x x _ _ _ x x x _ _ _ _",
      },
    },
    cmd = "QMKFormat",
  },
  {
    "nvim-lua/plenary.nvim",
    dir = require("config.utils").dev_dir("plenary.nvim"),
    keys = {
      { "<leader>pt", "<Plug>PlenaryTestFile", desc = "plenary run test" },
    },
    init = function()
      RELOAD = require("plenary.reload").reload_module

      R = function(name)
        RELOAD(name)
        return require(name)
      end
    end,
  },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = "leetcode.nvim" ~= vim.fn.argv()[1],
    opts = {
      lang = "python3",
      description = { position = "right" },
      injector = {
        ["python3"] = {
          before = "from typing import *",
          after = '"""\n\n"""',
        },
        ["golang"] = {
          before = "package main",
          after = "/*\n\n*/",
        },
      },
      storage = { home = "~/projects/leetcode" },
    },
    enabled = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  {
    "thePrimeagen/harpoon",
    opts = {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        excluded_filetypes = { "harpoon" },
      },
    },
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end },
      { "<leader>e", function() require("harpoon.ui").toggle_quick_menu() end },
      { "<leader>ho", function() require("harpoon.ui").nav_file(1) end },
      { "<leader>he", function() require("harpoon.ui").nav_file(2) end },
      { "<leader>ht", function() require("harpoon.ui").nav_file(3) end },
      { "<leader>hn", function() require("harpoon.ui").nav_file(4) end },
      { "<leader>to", function() require("harpoon.term").gotoTerminal(1) end },
      { "<leader>te", function() require("harpoon.term").gotoTerminal(2) end },
    },
  },

  -- Lua
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qa", function() require("persistence").load() end },
    },
  },

  {
    "docgen.nvim",
    dir = require("config.utils").dev_dir("docgen.nvim"),
    enabled = false,
  },

  { "MagicDuck/grug-far.nvim", opts = {} },

  {
    "stevearc/quicker.nvim",
    opts = {
      keys = {
        {
          ">",
          function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function() require("quicker").collapse() end,
          desc = "Collapse quickfix context",
        },
      },
    },
  },
}
