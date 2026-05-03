return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "tjdevries/colorbuddy.vim",
    priority = 1555,
    tag = "v1.0.0",
    config = function() vim.cmd.colorscheme("onedarkish") end,
  },
  { "brenoprata10/nvim-highlight-colors", opts = {}, cmd = { "HighlightColors" } },
  { "lewis6991/satellite.nvim", config = true },
  {
    "Bekaboo/dropbar.nvim",
    opts = {},
  },
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {}, -- required even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
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
