local packer = require("packer")
local use
local ts_update

--[[
  Installing all plugins from a local directory for work
  Only exception is packer itself which I manually put into the packer path (why??)

  bootstrap on work machine:
  ```
  lua require'plugins'
  PackerInstall
  ```
]]
if Work then
  use = function(opts)
    opts = opts or {}
    local install_path = "~/neovim/plugins"
    if type(opts) == "string" then
      opts = install_path .. opts:match("%/.*")
    else
      opts[1] = install_path .. opts[1]:match("%/.*")
    end
    packer.use(opts)
  end
  ts_update = nil
else
  use = packer.use
  ts_update = function() require("nvim-treesitter.install").update({ with_sync = true }) end
end

return packer.startup({
  function()
    -- packer itself
    packer.use({ "wbthomason/packer.nvim", lock = Work })

    use({ "nvim-lua/plenary.nvim" })

    -- LSP & Treeshitter
    use({ "nvim-treesitter/nvim-treesitter", run = ts_update })
    use({ "nvim-treesitter/nvim-treesitter-textobjects" })
    use({ "williamboman/mason.nvim", disable = Work })
    use({ "neovim/nvim-lspconfig" })
    use({ "L3MON4D3/LuaSnip" })
    use({ "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "saadparwaiz1/cmp_luasnip" })
    use({ "hrsh7th/cmp-cmdline" })
    use({ "rafamadriz/friendly-snippets" })
    use({ "folke/neodev.nvim" })
    use({ "b0o/SchemaStore.nvim" })
    use({ "simrat39/symbols-outline.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "nvim-treesitter/playground", event = "BufRead" })

    -- DAP
    use({ "mfussenegger/nvim-dap", disable = Work })
    use({ "leoluz/nvim-dap-go", disable = Work })
    use({ "rcarriga/nvim-dap-ui", disable = Work })
    use({ "theHamsta/nvim-dap-virtual-text", disable = Work })

    -- Telescope & File Management
    use({ "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-file-browser.nvim" })
    use({ "nvim-telescope/telescope-live-grep-args.nvim" })
    use({ "debugloop/telescope-undo.nvim" })
    use({ "thePrimeagen/harpoon" })

    -- Editing Support
    use({ "windwp/nvim-autopairs" })
    use({ "wellle/targets.vim" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" })
    use({ "numToStr/Comment.nvim" })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "norcalli/nvim-colorizer.lua" })
    use({ "ggandor/leap.nvim" })
    use({ "kylechui/nvim-surround" })
    use({ "booperlv/nvim-gomove" })
    use({ "andymass/vim-matchup" })
    use({ "gpanders/editorconfig.nvim", disable = Work })
    use({ "mattn/emmet-vim", event = "BufRead", disable = Work })
    use({ "Vimjas/vim-python-pep8-indent" })
    use({ "smjonas/live-command.nvim" })
    use({ "asiryk/auto-hlsearch.nvim" })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })
    use({ "jamestrew/git-worktree.nvim" })
    use({ "tpope/vim-fugitive" })
    use({ "TimUntersberger/neogit" })
    use({ "sindrets/diffview.nvim" })
    use({ "petertriho/cmp-git", disable = Work })

    -- Looks
    use({ "feline-nvim/feline.nvim" })
    use({ "SmiteshP/nvim-navic" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "tjdevries/colorbuddy.vim" })
    use({ "onsails/lspkind-nvim" })
    use({ "stevearc/dressing.nvim" })
    use({ "levouh/tint.nvim" })
    use({ "MunifTanjim/nui.nvim" })
    use({ "folke/noice.nvim" })

    -- Others
    use({ "kkharji/sqlite.lua", disable = Work })
    use({ "AckslD/nvim-neoclip.lua" })
    use({ "nathom/filetype.nvim" })
    use({ "lewis6991/impatient.nvim" })
    use({ "j-hui/fidget.nvim" })
    use({ "petertriho/nvim-scrollbar" })
    use({ "andweeb/presence.nvim", disable = Work })
    use({
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      run = "cd app && yarn install",
      cmd = "MarkdownPreview",
      disable = Work,
    })
    use({ "mrjones2014/smart-splits.nvim" })
    use({ "tpope/vim-dadbod" })
    use({ "kristijanhusak/vim-dadbod-ui" })
    use({ "kristijanhusak/vim-dadbod-completion" })
    use({ "samjwill/nvim-unception" })
    use({ "AckslD/messages.nvim" })
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function() return require("packer.util").float({ border = "single" }) end,
    },
  },
})
