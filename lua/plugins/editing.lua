return {
  { "wellle/targets.vim" },
  {
    "andymass/vim-matchup",
    event = "BufRead",
    opts = {
      matchparen = {
        offscreen = {
          method = "popup",
        },
      }
    }
  },
  { "windwp/nvim-autopairs", config = true },
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "jsx", "typescript", "tsx", "html", "markdown" },
  },
  { "kylechui/nvim-surround", config = true },
  { "nvim-mini/mini.move", config = true },
  {
    "Wansmer/treesj",
    keys = { { "<leader>sj", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150 },
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
