return {
  { "nvim-lua/plenary.nvim" },

  { "thePrimeagen/harpoon" },

  -- Editing Support
  { "windwp/nvim-autopairs" },
  { "wellle/targets.vim" },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "norcalli/nvim-colorizer.lua" },
  { "ggandor/leap.nvim" },
  { "kylechui/nvim-surround" },
  { "booperlv/nvim-gomove" },
  { "andymass/vim-matchup" },
  { "gpanders/editorconfig.nvim", enable = not Work },
  -- { "mattn/emmet-vim", event = "BufRead", enable = not Work },
  { "Vimjas/vim-python-pep8-indent" },
  { "smjonas/live-command.nvim" },
  { "asiryk/auto-hlsearch.nvim" },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = true,
  },
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>sj", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  -- Git
  { "lewis6991/gitsigns.nvim" },
  { "jamestrew/git-worktree.nvim" },
  { "tpope/vim-fugitive" },
  { "TimUntersberger/neogit" },
  { "sindrets/diffview.nvim" },

  -- Looks
  { "feline-nvim/feline.nvim" },
  { "SmiteshP/nvim-navic" },
  { "tjdevries/colorbuddy.vim" },
  { "onsails/lspkind-nvim" },
  { "stevearc/dressing.nvim" },
  { "levouh/tint.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "folke/noice.nvim" },
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

  -- Others
  { "kkharji/sqlite.lua", enable = not Work },
  { "nathom/filetype.nvim" },
  { "j-hui/fidget.nvim" },
  { "petertriho/nvim-scrollbar" },
  { "andweeb/presence.nvim", enable = not Work },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    opts = { app = "browser" },
    enable = not Work,
  },
  { "mrjones2014/smart-splits.nvim" },
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { "kristijanhusak/vim-dadbod-completion" },
  { "samjwill/nvim-unception" },
  { "AckslD/messages.nvim" },
}
