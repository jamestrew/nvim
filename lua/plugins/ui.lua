return {
  { "brenoprata10/nvim-highlight-colors", opts = {}, cmd = { "HighlightColors" } },
  { "lewis6991/satellite.nvim", config = true },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "▏" },
      scope = { show_start = false },
    },
  },

  {
    "j-hui/fidget.nvim",
    config = true,
  },

  {
    "akinsho/bufferline.nvim",
    event = "TabNew",
    opts = {
      options = {
        mode = "tabs",
        indicator = { style = "underline" },
        always_show_bufferline = false,
      },
    },
  },
}
