return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = "InsertEnter",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        group = vim.api.nvim_create_augroup("CopilotBlinkVisibility", { clear = true }),
        pattern = { "BlinkCmpMenuOpen", "BlinkCmpMenuClose" },
        callback = function(event)
          vim.b.copilot_suggestion_hidden = event.match == "BlinkCmpMenuOpen"
          local suggestion = package.loaded["copilot.suggestion"]
          if suggestion then suggestion.update_preview() end
        end,
      })
    end,
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
    "carlos-algms/agentic.nvim",
    event = "VeryLazy",

    opts = {
      -- Available by default: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "auggie-acp" | "mistral-vibe-acp"
      provider = "claude-agent-acp", -- setting the name here is all you need to get started
    },

    -- these are just suggested keymaps; customize as desired
    keys = {
      {
        "<C-\\>",
        function() require("agentic").toggle() end,
        mode = { "n", "v", "i" },
        desc = "Toggle Agentic Chat",
      },
      {
        "<C-'>",
        function() require("agentic").add_selection_or_file_to_context() end,
        mode = { "n", "v" },
        desc = "Add file or selection to Agentic to Context",
      },
      {
        "<C-,>",
        function() require("agentic").new_session() end,
        mode = { "n", "v", "i" },
        desc = "New Agentic Session",
      },
    },

    config = function(_, opts)
      require("agentic").setup(opts)
      require("config.utils").code_block_autoppairs_rule("AgenticInput")
    end,
  },
}
