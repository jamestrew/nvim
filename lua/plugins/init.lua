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
  { "mattn/emmet-vim", event = "BufRead", enable = not Work },
  { "Vimjas/vim-python-pep8-indent" },
  { "smjonas/live-command.nvim" },
  { "asiryk/auto-hlsearch.nvim" },

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

  -- Others
  { "kkharji/sqlite.lua", enable = not Work },
  { "nathom/filetype.nvim" },
  { "lewis6991/impatient.nvim" },
  { "j-hui/fidget.nvim" },
  { "petertriho/nvim-scrollbar" },
  { "andweeb/presence.nvim", enable = not Work },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
    enable = not Work,
  },
  { "mrjones2014/smart-splits.nvim" },
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { "kristijanhusak/vim-dadbod-completion" },
  { "samjwill/nvim-unception" },
  { "AckslD/messages.nvim" },
}
