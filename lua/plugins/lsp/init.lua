local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "SmiteshP/nvim-navic" },
    {
      "lewis6991/hover.nvim",
      config = function()
        require("hover").setup({
          init = function() require("hover.providers.lsp") end,
        })

        vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
      end,
    },
    {
      "williamboman/mason.nvim",
      opts = {
        ui = { keymaps = { update_all_packages = "S" } },
      },
      cmd = "Mason",
    },
    {
      "nvimtools/none-ls.nvim",
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            -- formatting
            null_ls.builtins.formatting.biome,
            null_ls.builtins.formatting.gofmt,
            null_ls.builtins.formatting.golines,
            null_ls.builtins.formatting.markdownlint,
            -- null_ls.builtins.formatting.sql_formatter,
            null_ls.builtins.formatting.sqlfluff.with({
              extra_args = { "--dialect", "sqlite" }, -- change to your dialect
            }),

            null_ls.builtins.formatting.goimports,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.nixpkgs_fmt,
            null_ls.builtins.diagnostics.sqlfluff.with({
              extra_args = { "--dialect", "sqlite" }, -- change to your dialect
            }),

            -- null_ls.builtins.formatting.sql_formatter,

            -- diagnostic
            -- null_ls.builtins.diagnostics.luacheck, too much
            null_ls.builtins.diagnostics.zsh,

            -- code_actions
            -- null_ls.builtins.code_actions.gitsigns,
          },
          on_attach = function(_, bufnr) require("plugins.lsp.utils").attach_mappings(bufnr) end,
        })
      end,
    },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv", "vim%.loop" } },
          { path = "luassert-types/library", words = { "assert" } },
          { path = "busted-types/library", words = { "describe" } },
        },
      },
      dependencies = {
        { "Bilal2453/luvit-meta", lazy = true },
        { "LuaCATS/luassert", name = "luassert-types", lazy = true },
        { "LuaCATS/busted", name = "busted-types", lazy = true },
      },
    },
    { "b0o/SchemaStore.nvim" },
    {
      "mrcjkb/rustaceanvim",
      version = "^5",
      lazy = false, -- This plugin is already lazy
      config = function()
        vim.g.rustaceanvim = function()
          ---@diagnostic disable-next-line: param-type-mismatch
          local mason_path = vim.fs.joinpath(vim.fn.stdpath("data"), "/mason")
          local ext_path = vim.fs.joinpath(mason_path, "packages", "codelldb", "extension")
          local codelldb_path = vim.fs.joinpath(ext_path, "adapter", "codelldb")
          local liblldb_path = vim.fs.joinpath(ext_path, "lldb", "lib", "liblldb.so")

          local cfg = require("rustaceanvim.config")

          return {
            -- Plugin configuration
            tools = {},
            -- LSP configuration
            server = {
              on_attach = function(client, bufnr)
                require("plugins.lsp.utils").on_attach(client, bufnr)
                vim.keymap.set("n", "<leader>K", ":RustLsp openDocs<CR>")
              end,
              default_settings = require("plugins.lsp.settings")["rust_analyzer"].settings,
            },
            -- DAP configuration
            dap = {
              adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            },
          }
        end
      end,
    },
    {
      "saecki/crates.nvim",
      tag = "stable",
      opts = {
        lsp = {
          enabled = true,
          on_attach = require("plugins.lsp.utils").on_attach,
          actions = true,
          completion = true,
          hover = true,
        },
      },
    },
    {
      "hedyhli/outline.nvim",
      opts = {
        outline_window = {
          auto_close = true,
          position = "left",
          relative_width = false,
          width = 40,
        },
        symbol_folding = {
          autofold_depth = 1,
        },
      },
      keys = { { "<leader>so", "<cmd>Outline<CR>", desc = "symbols-outline" } },
    },
    {
      -- "RRethy/vim-illuminate", -- seems unmaintained, lots of to-be-deprecated function use
      "jamestrew/vim-illuminate", -- merged in some PRs
      enabled = false, -- https://github.com/RRethy/vim-illuminate/issues/219
      config = function() require("illuminate").configure({}) end,
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  init = function() vim.api.nvim_create_augroup("lsp_augroup", { clear = true }) end,
  config = function()
    local lspsettings = require("plugins.lsp.settings")
    local lsputils = require("plugins.lsp.utils")
    local lspconfig = require("lspconfig")

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- replace the default lsp diagnostic letters with prettier symbols
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅙",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "󰋼",
          [vim.diagnostic.severity.HINT] = "󰌵",
        },
      },
    })

    vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
    vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
    vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])

    for _, server in ipairs(lspsettings.server_list) do
      local opts = {
        on_attach = lsputils.on_attach,
        capabilities = capabilities,
      }
      opts = vim.tbl_deep_extend("keep", opts, lspsettings[server] or {})
      lspconfig[server].setup(opts)
    end
  end,
}

return M
