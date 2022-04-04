local packer = require("packer")
local use

--[[
  Installing all plugins from a local directory for work
  Only exception is packer itself which I manually put into the packer path (why??)
]]

if Working then
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
    if Working then
      packer.use({ "wbthomason/packer.nvim" })
    else
      use({ "wbthomason/packer.nvim" })
    end

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

    -- Git
    use({ "lewis6991/gitsigns.nvim" })
    use({ "ThePrimeagen/git-worktree.nvim", lock = true })
    use({ "tpope/vim-fugitive" })

    -- Looks
    use({ "NTBBloodbath/galaxyline.nvim" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "tjdevries/colorbuddy.vim" })
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

    -- Work vs not Work
    if not Working then
      use({ "andweeb/presence.nvim" })
      use({ "tpope/vim-scriptease" })
      use({
        "glacambre/firenvim",
        run = function()
          vim.fn["firenvim#install"](0)
        end,
      })
      use({ "TimUntersberger/neogit" })
      use({ "sindrets/diffview.nvim" })
      use({
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
      })
      use({ "mattn/emmet-vim", event = "BufRead" })
      use({ "editorconfig/editorconfig-vim" })
      use({ "nvim-treesitter/playground", event = "BufRead" })
      use({ "petertriho/cmp-git" })

      -- experimental
      use({ "kyazdani42/nvim-tree.lua" })
    end

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
