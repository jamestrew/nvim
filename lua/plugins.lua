local packer = require("packer")
local use = packer.use



-- Auto sync
vim.cmd 'autocmd BufWritePost init.lua PackerSync'
vim.cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'

return packer.startup(
    function()
        use "wbthomason/packer.nvim"

        use {
            "glepnir/galaxyline.nvim",
            config = function()
                require("core.statusline").config()
            end
        }

        -- color related stuff
        use "siduck76/nvim-base16.lua"

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("colorizer").setup()
                vim.cmd("ColorizerReloadAllBuffers")
            end
        }

        -- language related plugins
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require("core.treesitter").config()
            end
        }

        use {
            "kabouzeid/nvim-lspinstall",
            event = "BufRead"
        }

        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lspinstall",
            config = function()
                require("core.lspconfig").config()
            end
        }

        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("lspkind").init()
            end
        }

        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("core.compe").config()
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require("core.compe").snippets()
                    end
                },
                {
                    "rafamadriz/friendly-snippets",
                    event = "InsertCharPre"
                }
            }
        }

        use {"sbdchd/neoformat", cmd = "Neoformat"}

        -- file managing , picker etc
        use {
          "kyazdani42/nvim-tree.lua",
          cmd = "NvimTreeToggle",
          config = function()
            require("core.nvimtree").config()
          end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("core.icons").config()
            end
        }

        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"}
            },
            config = function()
                require("core.telescope").config()
            end
        }

        use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
        use {"nvim-telescope/telescope-media-files.nvim"}

        -- git stuff
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("core.gitsigns").config()
            end
        }

        -- misc plugins
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
            config = function()
                require("nvim_comment").setup()
            end
        }

        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            setup = function()
                require("utils").blankline()
            end
        }
    end
)
