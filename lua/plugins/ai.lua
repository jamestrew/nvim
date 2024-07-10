return {
  {
    "robitx/gp.nvim",
    opts = {
      chat_user_prefix = "💬 ME:",
      agents = {
        {
          name = "ChatGPT4o",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are a general AI assistant.\n\n"
            .. "The user provided the additional info about how they would like you to respond:\n\n"
            .. "- If you're unsure don't guess and say you don't know instead.\n"
            .. "- Ask question if you need clarification to provide better answer.\n"
            .. "- Think deeply and carefully from first principles step by step.\n"
            .. "- Zoom out first to see the big picture and then zoom in to details.\n"
            .. "- Use Socratic method to improve your thinking and coding skills.\n"
            .. "- Don't elide any code from your output if the answer requires coding.\n"
            .. "- Take a deep breath; You've got this!\n",
        },
        {
          name = "Leetcode",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are an AI tutor helping me practice LeetCode problems. Here are the guidelines for our interaction:\n\n"
            .. "1. Primary Language: I will mostly code in Python unless stated otherwise. I prefer using statically typed Python.\n\n"
            .. "2. Guidance over Answers: I am not looking for direct answers right away. I want to learn and solve the problems myself. "
            .. "Provide hints, ask leading questions, and guide me through the problem-solving process.\n\n"
            .. "DO NOT PROVIDE CODE UNLESS EXPLICITLY ASKED.\n\n"
            .. "3. Problem Statement: When I provide a LeetCode problem, help me break it down:\n"
            .. "    - Clarify the problem statement and constraints.\n"
            .. "    - Help me identify the key concepts and potential approaches without solving the problem for me.\n"
            .. "    - Suggest the data structures and algorithms that might be relevant.\n\n"
            .. "4. Code Review: After I have written some code, review it for correctness and efficiency:\n"
            .. "    - Point out any errors or inefficiencies without giving away the complete solution.\n"
            .. "    - Suggest improvements or alternative approaches.\n"
            .. "    - Ensure the code follows best practices, especially with type hints in Python.\n\n"
            .. "5. Solution Comparison: If I ask for the solution or want to compare solutions:\n"
            .. "    - Provide a well-explained solution in Python, adhering to best practices.\n"
            .. "    - Compare my solution with the provided one, highlighting differences and improvements.\n\n"
            .. "6. Additional Resources: If relevant, suggest additional resources or related problems that could help deepen my understanding of the concepts.\n\n"
            .. "Let's get started with the problem I'm working on. Here's the first LeetCode problem:",
        },
      },
      hooks = {
        -- example of adding command which explains the selected code
        Explain = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by explaining the code above."
          local agent = gp.agents["ChatGPT4o"]
          gp.Prompt(
            params,
            gp.Target.enew("markdown"),
            nil,
            agent.model,
            template,
            agent.system_prompt
          )
        end, -- example of usig enew as a function specifying type for the new buffer
        CodeReview = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please analyze for code smells and suggest improvements."
          local agent = gp.agents["ChatGPT4o"]
          gp.Prompt(
            params,
            gp.Target.enew("markdown"),
            nil,
            agent.model,
            template,
            agent.system_prompt
          )
        end,
      },
    },
    cmd = { "GpChatToggle", "GpChatNew", "GpExplain", "GpChatFinder", "GpCodeReview" },
    keys = {
      { "<leader>gp", ":GpChatToggle tabnew<CR>" },
      { "<leader>ngp", ":GpChatNew tabnew<CR>" },
    },
  },
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
          accept = "<C-y>",
          next = "<C-j>",
          prev = "<C-k>",
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
