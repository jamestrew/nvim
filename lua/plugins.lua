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

    -- LSP & Treeshitter
    use({
      "nvim-treesitter/nvim-treesitter",
      branch = "0.5-compat",
      event = "BufRead",
      config = function()
        require("setup.treesitter").config()
      end,
    })
    use({ "williamboman/nvim-lsp-installer" })
    use({
      "neovim/nvim-lspconfig",
      config = function()
        require("setup.lspconfig").config()
      end,
    })
    use({ "L3MON4D3/LuaSnip" })
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("setup.cmp").config()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "petertriho/cmp-git",
      },
    })
    use({ "ray-x/lsp_signature.nvim" })
    use({ "folke/lua-dev.nvim" })
    use({ "nvim-treesitter/playground", event = "BufRead" })
    use({ "jparise/vim-graphql", event = "BufRead" })
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", event = "BufRead" })
    use({ "David-Kunz/treesitter-unit", event = "BufRead" })
    -- use({
    --   "simrat39/symbols-outline.nvim",
    --   config = function()
    --     require("setup.symbols").config()
    --   end,
    --   event = "BufRead",
    -- })
    local_use("symbols-outline.nvim", nil, {
      config = function()
        require("setup.symbols").config()
      end,
      event = "BufRead",
    })

    -- Telescope & File Management
    use({ "kevinhwang91/rnvimr" })
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
      },
      config = function()
        require("setup.telescope").config()
      end,
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    -- use({ "nvim-telescope/telescope-frecency.nvim", requires = { "tami5/sql.nvim" } })
    use({
      "ThePrimeagen/harpoon",
      config = function()
        require("setup.harpoon")
      end,
    })

    -- Editing Support
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end,
    })
    -- use { "andymass/vim-matchup", event = "CursorMoved" }
    use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" })
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("setup.comment").config()
      end,
    })
    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      setup = function()
        require("setup.blankline")
      end,
    })
    use({ "sbdchd/neoformat", cmd = "Neoformat" })
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require("colorizer").setup()
        vim.cmd("ColorizerReloadAllBuffers")
      end,
    })
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup()
      end,
    })
    use({
      "phaazon/hop.nvim",
      as = "hop",
      config = function()
        require("hop").setup({ keys = "tnhesoaiwfrudpclvkmzq" })
      end,
    })
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
    use({
      "abecodes/tabout.nvim",
      event = "BufRead",
      config = function()
        require("tabout").setup()
      end,
    })
    use({
      "ThePrimeagen/refactoring.nvim",
      event = "BufRead",
      config = function()
        require("refactoring").setup()
      end,
      commit = "41caf9d207887779255fa659a2ddb2182b158e3b",
    })

    -- Git
    use({
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require("setup.gitsigns").config()
      end,
    })
    -- use({
    --   "TimUntersberger/neogit",
    --   requires = "nvim-lua/plenary.nvim",
    --   config = function()
    --     require("setup.neogit").config()
    --   end,
    -- })
    use({ "tpope/vim-fugitive" })
    use({
      "ThePrimeagen/git-worktree.nvim",
      config = function()
        require("setup.worktree").config()
      end,
    })
    -- local_use "git-worktree.nvim/telescope-opts"

    -- Looks
    use({
      "glepnir/galaxyline.nvim",
      config = function()
        require("setup.statusline").config()
      end,
    })
    use({ "kyazdani42/nvim-web-devicons" })
    use({
      "tjdevries/colorbuddy.vim",
      config = function()
        require("setup.theme")
      end,
    })
    use({
      "RRethy/vim-illuminate",
      event = "CursorHold",
      module = "illuminate",
      config = function()
        vim.g.Illuminate_delay = 0
      end,
    })

    -- Others
    use({ "ThePrimeagen/vim-be-good" })
    use({ "kwkarlwang/bufresize.nvim" })
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup()
      end,
    })
    use({
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    })
    use({
      "andweeb/presence.nvim",
      config = function()
        require("setup.presence").config()
      end,
    })
    use({
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
    })
    use("nathom/filetype.nvim")
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
