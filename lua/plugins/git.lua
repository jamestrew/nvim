return {
  { "tpope/vim-fugitive" },
  { "jamestrew/git-worktree.nvim", config = true },
  {
    "sindrets/diffview.nvim",
    opts = { enhanced_diff_hl = false },
    config = function()
      vim.api.nvim_create_user_command("DiffViewToggle", function()
        if require("diffview.lib").get_current_view() then
          vim.cmd(":DiffviewClose")
        else
          vim.cmd(vim.fn.input({ prompt = "", default = ":DiffviewOpen " }))
        end
      end, {})
    end,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = { { "<leader>dv", "<cmd>DiffViewToggle<CR>", desc = "diffview" } },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        numhl = true,
        current_line_blame = true,
        watch_gitdir = { interval = 1000, follow_files = true },
        sign_priority = 5,
        status_formatter = nil, -- Use default
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, opts)
            opts = vim.tbl_extend("force", { silent = true, buffer = bufnr }, opts or {})
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", gs.blame_line)
          map("n", "<leader>hu", gs.undo_stage_hunk)
          map(
            "v",
            "<leader>hs",
            function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end
          )
          map(
            "v",
            "<leader>hr",
            function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end
          )

          map("n", "]g", function()
            if vim.wo.diff then return "]g" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[g", function()
            if vim.wo.diff then return "[g" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true })
        end,
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = { "sindrets/diffview.nvim" },
    opts = {
      disable_commit_confirmation = true,
      kind = "tab",
      integrations = { diffview = true },
      sections = { recent = { folded = false } },
      mappings = { status = { ["="] = "Toggle" } },
    },
    cmd = { "Neogit" },
    keys = { { "<leader>gs", "<cmd>Neogit<CR>", desc = "neogit" } },
  },
}
