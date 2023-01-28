return {
  { "nvim-lua/plenary.nvim" },

  -- LSP & Treeshitter

  -- DAP
  { "mfussenegger/nvim-dap", enable = not Work },
  { "leoluz/nvim-dap-go", enable = not Work },
  { "rcarriga/nvim-dap-ui", enable = not Work },
  { "theHamsta/nvim-dap-virtual-text", enable = not Work },

  -- Telescope & File Management
  { "nvim-telescope/telescope.nvim" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "debugloop/telescope-undo.nvim" },
  { "thePrimeagen/harpoon" },

  -- Editing Support
  { "windwp/nvim-autopairs" },
  { "wellle/targets.vim" },
  { "numToStr/Comment.nvim" },
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
  { "kyazdani42/nvim-web-devicons" },
  { "tjdevries/colorbuddy.vim" },
  { "onsails/lspkind-nvim" },
  { "stevearc/dressing.nvim" },
  { "levouh/tint.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "folke/noice.nvim" },

  -- Others
  { "kkharji/sqlite.lua", enable = not Work },
  { "AckslD/nvim-neoclip.lua" },
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
