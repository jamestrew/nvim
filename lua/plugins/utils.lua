return {
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
    dir = "~/projects/plenary.nvim",
    keys = {
      { "<leader>pt", "<Plug>PlenaryTestFile", desc = "plenary run test" },
    },
  },
  { "andweeb/presence.nvim", config = true },
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
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      resize_mode = {
        silent = true,
        hooks = {
          on_enter = function() vim.notify("Entering resize mode") end,
          on_leave = function() vim.notify("Exiting resize mode, bye") end,
        },
      },
    },
    keys = {
      {
        "<leader>sp",
        function() require("smart-splits").start_resize_mode() end,
        desc = "smart split",
      },
    },
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
        excluded_filetypes = { "harpoon", "TelescopePrompt" },
      },
    },
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end },
      { "<leader>e", function() require("harpoon.ui").toggle_quick_menu() end },
      { "<leader>hn", function() require("harpoon.ui").nav_file(1) end },
      { "<leader>he", function() require("harpoon.ui").nav_file(2) end },
      { "<leader>ho", function() require("harpoon.ui").nav_file(3) end },
      { "<leader>hi", function() require("harpoon.ui").nav_file(4) end },
      { "<leader>tn", function() require("harpoon.term").gotoTerminal(1) end },
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
    dir = "~/projects/docgen.nvim",
  },

  { "MagicDuck/grug-far.nvim", opts = {} },
}
