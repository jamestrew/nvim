return {
  { "samjwill/nvim-unception" },
  {
    "codethread/qmk.nvim",
    opts = {
      name = "LAYOUT_manuform_num",
      layout = {
        "x x x x x x _ _ _ _ _ x x x x x x",
        "x x x x x x _ _ _ _ _ x x x x x x",
        "x x x x x x _ _ _ _ _ x x x x x x",
        "x x x x x x _ _ _ _ _ x x x x x x",
        "x x x x x x x _ _ _ x x x x x x x",
        "_ _ _ _ x x x _ _ _ x x x _ _ _ _",
      },
    },
  },
  {
    "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>pt", "<Plug>PlenaryTestFile", desc = "plenary run test" },
    },
  },
  { "andweeb/presence.nvim", config = true },
  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("sg").setup({
  --       on_attach = require("plugins.lsp").on_attach,
  --     })
  --   end,
  },
  {
    "AckslD/messages.nvim",
    config = function()
      require("messages").setup({
        prepar_buffer = function(opts)
          local buf = vim.api.nvim_create_buf(false, true)
          vim.keymap.set("n", "<esc>", "<cmd>close<CR>", { buffer = buf })
          return vim.api.nvim_open_win(buf, true, opts)
        end,
      })
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      resize_mode = {
        silent = true,
        hooks = {
          on_enter = function() vim.notify("Entering resize mode") end,
          on_leave = function() vim.notify("Exiting resize mode, bye") end,
        },
      },
    },
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
  },
  {
    "thePrimeagen/harpoon",
    opts = {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        excluded_filetypes = { "harpoon", "TelescopePrompt" },
      },
    },
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end },
      { "<leader>e", function() require("harpoon.ui").toggle_quick_menu() end },
      { "<leader>hn", function() require("harpoon.ui").nav_file(1) end },
      { "<leader>he", function() require("harpoon.ui").nav_file(2) end },
      { "<leader>ho", function() require("harpoon.ui").nav_file(3) end },
      { "<leader>hi", function() require("harpoon.ui").nav_file(4) end },
      { "<leader>tn", function() require("harpoon.term").gotoTerminal(1) end },
      { "<leader>te", function() require("harpoon.term").gotoTerminal(2) end },
    },
  },
}
