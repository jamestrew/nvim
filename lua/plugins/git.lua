return {
  {
    "tpope/vim-fugitive",
    -- keys = { { "<leader>gs", "<cmd>G<CR>", desc = "git" } },
    cmd = { "G" },
  },

  {
    "NeogitOrg/neogit",
    dependencies = { "sindrets/diffview.nvim" },
    opts = {
      kind = "tab",
      disable_line_numbers = false,
      disable_insert_on_commit = true,
      integrations = { diffview = true },
      sections = { recent = { folded = false } },
      mappings = { status = { ["="] = "Toggle" } },
    },
    cmd = { "Neogit" },
    keys = { { "<leader>gs", "<cmd>Neogit<CR>", desc = "neogit" } },
    config = function(_, opts)
      require("neogit").setup(opts)
      vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = "NeogitStatus",
        callback = function()
          vim.schedule(function() vim.wo.rnu = true end)
        end,
      })
    end,
  },

  {
    "sindrets/diffview.nvim",
    opts = { enhanced_diff_hl = false },
    init = function()
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
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = "cmake -B build && cmake --build build",
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
          local gs = require("gitsigns")

          local map = function(mode, l, r, opts)
            opts = opts or { silent = true, buffer = bufnr }
            vim.keymap.set(mode, l, r, opts)
          end

          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", gs.blame_line)
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

          -- Navigation
          map("n", "]g", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]g", bang = true })
            else
              gs.nav_hunk("next")
            end
          end)

          map("n", "[g", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[g", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end)
        end,
      })
    end,
  },
}
