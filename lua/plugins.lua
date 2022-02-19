local packer = require("packer")
local use = packer.use

-- Auto sync
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerSync]])

return packer.startup({
  function()
    local local_use = function(first, second, opts)
      opts = opts or {}
      local plug_path, home
      if second == nil then
        plug_path = first
        home = "jt"
      else
        plug_path = second
        home = first
      end

      if vim.fn.isdirectory(vim.fn.expand("~/Documents/projects/" .. plug_path)) == 1 then
        opts[1] = "~/Documents/projects/" .. plug_path
      else
        opts[1] = string.format("%s/%s", home, plug_path)
      end

      use(opts)
    end

    -- packer itself
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")

    -- LSP & Treeshitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      commit = "723d91e8217ae66ea75f809f404d801ed939f497",
    })
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
      "petertriho/cmp-git",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    })
    use({ "folke/lua-dev.nvim" })
    use({ "nvim-treesitter/playground", event = "BufRead" })
    use({ "jparise/vim-graphql", event = "BufRead" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", event = "BufRead" })
    use({ "David-Kunz/treesitter-unit", event = "BufRead" })
    use({ "romgrk/nvim-treesitter-context" })
    use("b0o/SchemaStore.nvim")
    use({ "simrat39/symbols-outline.nvim" })

    -- Telescope & File Management
    use({ "nvim-telescope/telescope.nvim" })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("nvim-telescope/telescope-file-browser.nvim")
    -- use({ "nvim-telescope/telescope-frecency.nvim", requires = { "tami5/sql.nvim" } })
    use({ "ThePrimeagen/harpoon" })

    -- Editing Support
    use({ "windwp/nvim-autopairs" })
    use("wellle/targets.vim")
    use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" })
    use({ "numToStr/Comment.nvim" })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "sbdchd/neoformat", cmd = "Neoformat" })
    use({ "norcalli/nvim-colorizer.lua", event = "BufRead" })
    use({ "folke/todo-comments.nvim" })
    use("ggandor/lightspeed.nvim")
    use({ "tpope/vim-surround", event = "BufRead" })
    use({ "tpope/vim-repeat", event = "BufRead" })
    use({ "mattn/emmet-vim", event = "BufRead" })
    use({ "editorconfig/editorconfig-vim" })
    use({ "mbbill/undotree", event = "BufRead" })
    use({
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      run = "cd app && yarn install",
      cmd = "MarkdownPreview",
    })
    use({ "ThePrimeagen/refactoring.nvim", event = "BufRead" })
    use({ "booperlv/nvim-gomove" })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })
    use({ "tpope/vim-fugitive" })
    use({ "ThePrimeagen/git-worktree.nvim" })

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
    use({ "folke/which-key.nvim" })
    use({ "AckslD/nvim-neoclip.lua" })
    use({
      "andweeb/presence.nvim",
    })
    use({
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
    })
    use("nathom/filetype.nvim")
    -- local_use("dimmer.nvim", nil, {
    --   config = function()
    --     require("setup.dimmer").config()
    --   end,
    -- })
    use("lewis6991/impatient.nvim")
    use("j-hui/fidget.nvim")
    use("rcarriga/nvim-notify")
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
