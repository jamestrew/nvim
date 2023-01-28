local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  { "nvim-lua/plenary.nvim" },

  -- LSP & Treeshitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "williamboman/mason.nvim" },
  { "neovim/nvim-lspconfig" },
  { "L3MON4D3/LuaSnip" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-cmdline" },
  { "rafamadriz/friendly-snippets" },
  { "folke/neodev.nvim" },
  { "b0o/SchemaStore.nvim" },
  { "simrat39/symbols-outline.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "nvim-treesitter/playground", event = "BufRead" },

  -- DAP
  { "mfussenegger/nvim-dap" },
  { "leoluz/nvim-dap-go" },
  { "rcarriga/nvim-dap-ui" },
  { "theHamsta/nvim-dap-virtual-text" },

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
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" },
  { "numToStr/Comment.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "norcalli/nvim-colorizer.lua" },
  { "ggandor/leap.nvim" },
  { "kylechui/nvim-surround" },
  { "booperlv/nvim-gomove" },
  { "andymass/vim-matchup" },
  { "gpanders/editorconfig.nvim" },
  { "mattn/emmet-vim", event = "BufRead" },
  { "Vimjas/vim-python-pep8-indent" },
  { "smjonas/live-command.nvim" },
  { "asiryk/auto-hlsearch.nvim" },

  -- Git
  { "lewis6991/gitsigns.nvim" },
  { "jamestrew/git-worktree.nvim" },
  { "tpope/vim-fugitive" },
  { "TimUntersberger/neogit" },
  { "sindrets/diffview.nvim" },
  { "petertriho/cmp-git" },

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
  { "kkharji/sqlite.lua" },
  { "AckslD/nvim-neoclip.lua" },
  { "nathom/filetype.nvim" },
  { "j-hui/fidget.nvim" },
  { "petertriho/nvim-scrollbar" },
  { "andweeb/presence.nvim" },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
  },
  { "mrjones2014/smart-splits.nvim" },
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { "kristijanhusak/vim-dadbod-completion" },
  { "samjwill/nvim-unception" },
  { "AckslD/messages.nvim" },
})
