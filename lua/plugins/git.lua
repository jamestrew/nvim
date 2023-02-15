return {
  { "tpope/vim-fugitive" },
  { "jamestrew/git-worktree.nvim", config = true },
  { "sindrets/diffview.nvim", opts = { enhanced_diff_hl = true } },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        numhl = true,
        current_line_blame = true,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        sign_priority = 5,
        status_formatter = nil, -- Use default
        on_attach = function(bufnr)
          local opts = { silent = true, buffer = bufnr }

          local gs = require("gitsigns")
          local utils = require("utils")
          local nnoremap = utils.nnoremap
          local vnoremap = utils.vnoremap
          nnoremap("<leader>hs", gs.stage_hunk, opts)
          nnoremap("<leader>hu", gs.undo_stage_hunk, opts)
          nnoremap("<leader>hp", gs.preview_hunk, opts)
          nnoremap("<leader>hb", gs.blame_line, opts)
          nnoremap("<leader>hr", gs.reset_hunk, opts)

          vnoremap("<leader>hs", gs.stage_hunk, opts)
          vnoremap("<leader>hr", gs.reset_hunk, opts)
        end,
      })
    end,
  },
  {
    "TimUntersberger/neogit",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    opts = {
      disable_commit_confirmation = true,
      kind = "tab",
      integrations = {
        diffview = true,
      },
      sections = {
        recent = {
          folded = false,
        },
      },
      mappings = {
        status = {

          ["="] = "Toggle",
        },
      },
    },
    keys = {
      { "<leader>gs", function() require("neogit").open() end, desc = "neogit" },
    },
  },
}
