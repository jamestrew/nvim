return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = "InsertEnter",
    opts = {
      -- suggestion = { enabled = false },
      -- panel = { enabled = false },
      lsp_binary = vim.fn.exepath("copilot-language-server"),
      suggestion = {
        enabled = vim.fn.argv()[1] ~= "leetcode.nvim",
        auto_trigger = true,
        keymap = {
          accept = "<C-v>",
          next = "<C-x>",
          dismiss = "<C-z>",
        },
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "copilot",
      providers = {
        copilot = {
          model = "o4-mini-2025-04-16",
        },
      },
      mappings = {
        toggle = {
          suggestion = "<leader><leader><leader>eontsont", -- lol
        },
      },
    },
    config = function(_, opts)
      local ft = "AvanteInput"
      local Rule = require("nvim-autopairs.rule")
      local npairs = require("nvim-autopairs")
      npairs.add_rules({
        Rule("```", "```", { ft }),
        Rule("```.*$", "```", { ft }):only_cr():use_regex(true),
      })
      require("avante").setup(opts)
    end,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      --- The below dependencies are optional,
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "Avante" },
        },
        ft = { "Avante" },
      },
    },
  },
}
