return {
  "nvim-telescope/telescope.nvim",
  dir = require("config.utils").dev_dir("telescope.nvim"),
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dir = require("config.utils").dev_dir("telescope-file-browser.nvim/master"),
      name = "telescope-file-browser.nvim",
    },
  },
  cmd = "Telescope",
}
