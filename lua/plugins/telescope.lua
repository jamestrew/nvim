return {
  {
    "nvim-telescope/telescope.nvim",
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
