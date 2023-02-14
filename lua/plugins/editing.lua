return {
  { "wellle/targets.vim" },
  { "andymass/vim-matchup" },
  { "Vimjas/vim-python-pep8-indent" },
  { "gpanders/editorconfig.nvim", enabled = not Work },
  { "windwp/nvim-autopairs", config = true },
  { "kylechui/nvim-surround", config = true },
  { "booperlv/nvim-gomove", name = "gomove", config = true },
  { "norcalli/nvim-colorizer.lua", name = "colorizer", config = true },
  { "asiryk/auto-hlsearch.nvim", config = true },

  {
    "ggandor/leap.nvim",
    config = function() require("leap").add_default_mappings() end,
  },

  {
    "Wansmer/treesj",
    keys = {
      { "<leader>sj", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "smjonas/live-command.nvim",
    name = "live-command",
    opts = {
      commands = {
        Norm = { cmd = "norm" },
        S = { cmd = "g" },
        Reg = {
          cmd = "norm",
          args = function(opts) return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args end,
          range = "",
        },
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
}
