return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = "InsertEnter",
    opts = {
      -- suggestion = { enabled = false },
      -- panel = { enabled = false },
      suggestion = {
        enabled = vim.fn.argv()[1] ~= "leetcode.nvim",
        auto_trigger = false,
        keymap = {
          accept = "<C-v>",
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
      prompts = {
        Review = {
          callback = function(_, _) end,
        },
      },
      auto_follow_cursor = false,
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
      {
        "<leader><leader>cp",
        function()
          require("CopilotChat").toggle({
            window = {
              layout = "horizontal",
            },
          })
        end,
      },
      { "<leader>ce", ":CopilotChatExplain<CR>", mode = "v" },
      { "<leader>cr", ":CopilotChatReview<CR>", mode = "v" },
    },
    cmd = {
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
      "CopilotChatFixDiagnostic",
      "CopilotChatCommit",
      "CopilotChatCommitStaged",
    },
  },
}
