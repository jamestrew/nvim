return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = "InsertEnter",
    opts = {
      -- suggestion = { enabled = false },
      -- panel = { enabled = false },
      suggestion = {
        auto_trigger = vim.fn.argv()[1] ~= "leetcode.nvim",
        keymap = {
          accept = "<C-c>",
          next = "<C-x>",
          dismiss = "<C-z>",
        },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      question_header = " Me ",
      answer_header = " Copilot ",
    },
    config = function(_, opts)
      local ft = "copilot-chat"
      local Rule = require("nvim-autopairs.rule")
      local npairs = require("nvim-autopairs")
      npairs.add_rules({
        Rule("```", "```", { ft }),
        Rule("```.*$", "```", { ft }):only_cr():use_regex(true),
      })

      require("CopilotChat").setup(opts)
    end,
    keys = {
      { "<leader>cp", ":CopilotChatToggle<CR>" },
      { "<leader>ce", ":CopilotChatExplain<CR>", mode = "v" },
      -- { "<leader>cr", ":CopilotCodeReview<CR>" },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
