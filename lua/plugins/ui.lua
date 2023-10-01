return {
  { "lewis6991/satellite.nvim", config = true },
  {
    "j-hui/fidget.nvim",
    opts = { text = { spinner = "bouncing_ball" }, timer = { spinner_rate = 250 } },
    enabled = false,
  },
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
    config = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "▏" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
        indicator = { style = "underline" },
        always_show_bufferline = false,
      },
    },
  },

  {
    "levouh/tint.nvim",
    enabled = false,
    opts = {
      tint = -45,
      tint_background_colors = false,
      highlight_ignore_patterns = { "WinSeparator", "Telescope*", "LineNr" },
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
        -- Do not tint `terminal` or floating windows, tint everything else
        return buftype == "terminal" or floating
      end,
    },
  },
  {
    "tummetott/reticle.nvim",
    event = "VeryLazy", -- lazyload the plugin if you like
    opts = {
      -- add options here if you want to overwrite defaults
    },
    enabled = false,
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
