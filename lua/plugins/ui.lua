return {
  { "petertriho/nvim-scrollbar", config = true },
  {
    "j-hui/fidget.nvim",
    opts = { text = { spinner = "bouncing_ball" }, timer = { spinner_rate = 250 } },
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
    opts = {
      char = "▏",
      filetype_exclude = { "help", "terminal", "dashboard", "man" },
      buftype_exclude = { "terminal", "nofile", "quickfix", "prompt" },
      show_trailing_blankline_indent = false,
      show_current_context = true,
      show_current_context_start = false,
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
}
