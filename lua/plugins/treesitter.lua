return {
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  { "nvim-treesitter/nvim-treesitter", build = not Work and ":TSUpdate" or nil },
}
