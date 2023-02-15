return {
  { "nathom/filetype.nvim" },
  { "samjwill/nvim-unception" },
  {
    "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>pt", "<Plug>PlenaryTestFile", desc = "plenary run test" },
    },
  },
  { "andweeb/presence.nvim", config = true, enabled = not Work },
  { "AckslD/messages.nvim", config = true },
  {
    "mrjones2014/smart-splits.nvim",
    config = true,
    keys = {
      {
        "<leader>sp",
        function() require("smart-splits").start_resize_mode() end,
        desc = "smart split",
      },
    },
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    opts = { app = "browser" },
    init = function() vim.api.nvim_create_user_command("Peek", require("peek").open, {}) end,
    enabled = not Work,
  },
  {
    "thePrimeagen/harpoon",
    opts = {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        mark_branch = not Work,
        excluded_filetypes = { "harpoon", "TelescopePrompt" },
      },
    },
    keys = {
      {
        "<leader>a",
        function() require("harpoon.mark").add_file() end,
        desc = "harpoon add file",
      },
      {
        "<leader>e",
        function() require("harpoon.ui").toggle_quick_menu() end,
        desc = "harpoon ui",
      },
      {
        "<leader>hn",
        function() require("harpoon.ui").nav_file(1) end,
        desc = "harpoon file 1",
      },
      {
        "<leader>he",
        function() require("harpoon.ui").nav_file(2) end,
        desc = "harpoon file 2",
      },
      {
        "<leader>ho",
        function() require("harpoon.ui").nav_file(3) end,
        desc = "harpoon file 3",
      },
      {
        "<leader>hi",
        function() require("harpoon.ui").nav_file(4) end,
        desc = "harpoon file 4",
      },
      {
        "<leader>tn",
        function() require("harpoon.term").gotoTerminal(1) end,
        desc = "harpoon term 1",
      },
      {
        "<leader>te",
        function() require("harpoon.term").gotoTerminal(2) end,
        desc = "harpoon term 2",
      },
    },
  },
}
