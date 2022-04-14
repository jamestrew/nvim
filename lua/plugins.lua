local packer = require("packer")
local use

--[[
  Installing all plugins from a local directory for work
  Only exception is packer itself which I manually put into the packer path (why??)
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
else
  use = packer.use
end

return packer.startup({
  function()
    -- packer itself
    packer.use({ "wbthomason/packer.nvim" })

    use({ "nvim-lua/plenary.nvim" })

    -- LSP & Treeshitter
    use({ "nvim-treesitter/nvim-treesitter" })
    use({ "williamboman/nvim-lsp-installer" })
    use({ "neovim/nvim-lspconfig" })
    use({ "L3MON4D3/LuaSnip" })
    use({
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    })
    use({ "folke/lua-dev.nvim" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", event = "BufRead" })
    use({ "romgrk/nvim-treesitter-context" })
    use({ "b0o/SchemaStore.nvim" })
    use({ "simrat39/symbols-outline.nvim" })
    use({ "jose-elias-alvarez/null-ls.nvim" })
    use({ "nvim-treesitter/playground", event = "BufRead", disable = Work })

    -- Telescope & File Management
    use({ "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-file-browser.nvim" })
    use({ "jamestrew/harpoon", branch = "telescope-file-browser" })

    -- Editing Support
    use({ "windwp/nvim-autopairs" })
    use({ "wellle/targets.vim" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" })
    use({ "numToStr/Comment.nvim" })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "norcalli/nvim-colorizer.lua", event = "BufRead" })
    use({ "phaazon/hop.nvim", event = "BufRead" })
    use({ "tpope/vim-surround", event = "BufRead" })
    use({ "tpope/vim-repeat", event = "BufRead" })
    use({ "mbbill/undotree", event = "BufRead" })
    use({ "booperlv/nvim-gomove" })
    use({ "andymass/vim-matchup" })
    use({ "editorconfig/editorconfig-vim", disable = Work })
    use({ "mattn/emmet-vim", event = "BufRead", disable = Work })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })
    use({ "jamestrew/git-worktree.nvim" })
    use({ "tpope/vim-fugitive" })
    use({ "TimUntersberger/neogit", disable = Work })
    use({ "sindrets/diffview.nvim", disable = Work })
    use({ "petertriho/cmp-git", disable = Work })

    -- Looks
    use({ "NTBBloodbath/galaxyline.nvim" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "tjdevries/colorbuddy.vim" })
    use({ "onsails/lspkind-nvim" })
    use({
      "RRethy/vim-illuminate",
      event = "CursorHold",
      module = "illuminate",
      config = function()
        vim.g.Illuminate_delay = 0
      end,
    })

    -- Others
    use({ "AckslD/nvim-neoclip.lua" })
    use({ "nathom/filetype.nvim" })
    use({ "lewis6991/impatient.nvim" })
    use({ "j-hui/fidget.nvim" })
    use({ "petertriho/nvim-scrollbar" })
    use({ "andweeb/presence.nvim", disable = Work })
    use({ "tpope/vim-scriptease", disable = Work })
    use({
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
      disable = Work,
    })
    use({
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      run = "cd app && yarn install",
      cmd = "MarkdownPreview",
      disable = Work,
    })

    -- experimental
    use({ "kyazdani42/nvim-tree.lua", disable = Work })
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
