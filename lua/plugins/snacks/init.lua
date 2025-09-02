return {
  "folke/snacks.nvim",
  dir = require("config.utils").dev_dir("snacks.nvim"),
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

    picker = require("plugins.snacks.pickers").defaults,
    image = { enabled = true },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false, replace_netrw = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = true, folds = { open = true } },
    words = { enabled = false },
  },
  keys = function()
    local Snacks = require("snacks")
    local pickers = require("plugins.snacks.pickers")
    return {
      -- { "<C-p>", function() Snacks.picker.files() end },
      { "<leader>fw", Snacks.picker.grep, silent = true },
      { "<leader>gc", Snacks.picker.git_log, silent = true },
      { "<leader>fb", pickers.buffers, silent = true },
      { "<leader>fh", Snacks.picker.help, silent = true },
      { "<leader>gw", Snacks.picker.grep_word, silent = true, mode = { "n", "v", "x" } },
      {
        "<C-e>",
        function() Snacks.picker.explorer() end,
      },
      {
        "<leader><C-e>",
        function() Snacks.picker.explorer({ cwd = vim.fn.expand("%:p:h"), follow_buffer = true }) end,
      },
      -- { "<leader><C-e>", function() pickers.file_browser({ follow_file = true }) end },
    }
  end,
}
