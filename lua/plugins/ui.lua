return {
  { "brenoprata10/nvim-highlight-colors", opts = {}, cmd = { "HighlightColors" } },
  { "lewis6991/satellite.nvim", config = true },
  {
    "stevearc/dressing.nvim",
    opts = {
      input = { enabled = false },
      select = { telescope = require("telescope.themes").get_cursor() },
    },
  },

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

  {
    "nvim-zh/colorful-winsep.nvim",
    enabled = true,
    opts = function()
      local colors = require("themes." .. vim.g.colors_name).colors
      return { highlight = { fg = colors.base0E } }
    end,
    event = { "WinNew" },
  },
}
