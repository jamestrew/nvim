return {
  { "wellle/targets.vim" },
  -- https://github.com/jamestrew/nvim/issues/83
  -- {
  --   "andymass/vim-matchup",
  --   event = "BufRead",
  --   config = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
  -- },
  { "windwp/nvim-autopairs", config = true },
  { "windwp/nvim-ts-autotag", ft = { "javascript", "jsx", "typescript", "tsx", "html", "markdown" } },
  { "kylechui/nvim-surround", config = true },
  { "echasnovski/mini.move", config = true },
  { "asiryk/auto-hlsearch.nvim", config = true },
  { "norcalli/nvim-colorizer.lua", cmd = { "ColorizerToggle" } },
  {
    "Wansmer/treesj",
    keys = { { "<leader>sj", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "smjonas/live-command.nvim",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
          S = { cmd = "g" },
          Reg = {
            cmd = "norm",
            args = function(opts)
              return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
            end,
            range = "",
          },
        },
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = function(_, opts)
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
      opts.ignore = "^$"
      opts.pre_hook =
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    end,
    event = "VeryLazy",
  },
}
