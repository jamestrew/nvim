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
          accept = "<M-l>",
          next = "<M-n>",
          dismiss = "<M-x>",
        },
      },
    },
  },
  {
    "folke/sidekick.nvim",
    ---@type sidekick.Config
    opts = {
      nes = { enabled = false },
      cli = {
        win = {
          split = {
            width = 120,
          },
          keys = {
            esc = { "<c-d>", function(t) t:send("") end },
          },
        },
        mux = {
          backend = "tmux",
          enabled = false,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").focus() end,
        desc = "Sidekick Switch Focus",
        mode = { "n", "v" },
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle({ focus = true }) end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
}
