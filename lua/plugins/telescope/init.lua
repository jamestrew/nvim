return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-file-browser.nvim", dev = true },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "tsakirist/telescope-lazy.nvim" },
  { "debugloop/telescope-undo.nvim" },
  {
    "AckslD/nvim-neoclip.lua",
    config = true,
    dependencies = {
      { "kkharji/sqlite.lua", enabled = not Work },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("plugins.telescope.setup")() end,
  },
}
