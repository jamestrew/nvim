local packer = require("packer")
local use = packer.use

-- Auto sync
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerSync]])

return packer.startup({
    function()
        -- packer itself
        use "wbthomason/packer.nvim"

        -- LSP & Treeshitter
        use {
            "nvim-treesitter/nvim-treesitter",
            branch = "0.5-compat",
            event = "BufRead",
            config = function() require("core.treesitter").config() end
        }
        use {"kabouzeid/nvim-lspinstall", event = "BufRead"}
        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lspinstall",
            config = function() require("core.lspconfig").config() end
        }
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function() require("core.compe").config() end,
        }
        use {"ray-x/lsp_signature.nvim"}
        use {"folke/lua-dev.nvim"}

        -- Telescope & File Management
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function() require("core.nvimtree").config() end
        }
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"}
            },
            config = function() require("core.telescope").config() end
        }
        use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
        use {"nvim-telescope/telescope-media-files.nvim"}
        use {
            "ThePrimeagen/harpoon",
            config = function() require("core.harpoon") end
        }

        -- Editing Support
        use {
            "windwp/nvim-autopairs",
            after = "nvim-compe",
            config = function()
                require("nvim-autopairs").setup()
                require("nvim-autopairs.completion.compe").setup(
                    {
                        map_cr = true,
                        map_complete = true -- insert () func completion
                    }
                )
            end
        }
        use {"andymass/vim-matchup", event = "CursorMoved"}
        use {
            "terrortylor/nvim-comment",
            config = function() require("nvim_comment").setup() end
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            setup = function() require("core.blankline") end
        }
        use {"sbdchd/neoformat", cmd = "Neoformat"}
        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("colorizer").setup()
                vim.cmd("ColorizerReloadAllBuffers")
            end
        }
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function() require("todo-comments").setup() end
        }
        use {
            'phaazon/hop.nvim',
            as = 'hop',
            config = function() require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' } end
        }
        use {"tpope/vim-surround", event = "BufRead"}
        use {"mattn/emmet-vim", event = "BufRead"}
        use {"editorconfig/editorconfig-vim"}
        use {"mbbill/undotree", event = "BufRead"}
        use {
            "iamcco/markdown-preview.nvim",
            ft = {"markdown"},
            run = "cd app && yarn install",
            cmd = "MarkdownPreview"
        }

        -- Git
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function() require("core.gitsigns").config() end
        }
        use {
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
            config = function () require("neogit").setup{} end
        }
        use {"ThePrimeagen/git-worktree.nvim"}

        -- Looks
        use {
            "glepnir/galaxyline.nvim",
            config = function() require("core.statusline").config() end
        }
        use "siduck76/nvim-base16.lua"
        use {
            "kyazdani42/nvim-web-devicons",
            config = function() require("core.icons").config() end
        }

        -- Others
        use {"ThePrimeagen/vim-be-good"}
        use {
            "folke/which-key.nvim",
            config = function() require("which-key").setup() end
        }
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})
