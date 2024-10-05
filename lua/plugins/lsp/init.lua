local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "SmiteshP/nvim-navic" },
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
            debug = true,
            -- formatting
            null_ls.builtins.formatting.biome,
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.gofmt,
            null_ls.builtins.formatting.golines,
            null_ls.builtins.formatting.markdownlint,
            -- null_ls.builtins.formatting.sql_formatter,
            null_ls.builtins.formatting.sqlfluff.with({
              extra_args = { "--dialect", "sqlite" }, -- change to your dialect
            }),

            null_ls.builtins.formatting.goimports,
            null_ls.builtins.formatting.stylua,
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
          debug = true,
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
          return {
            -- Plugin configuration
            tools = {},
            -- LSP configuration
            server = {
              on_attach = require("plugins.lsp.utils").on_attach,
              default_settings = {
                -- rust-analyzer language server configuration
                ["rust-analyzer"] = {
                  checkOnSave = true,
                  check = {
                    command = "clippy",
                  },
                  cargo = {
                    features = "all",
                  },
                },
              },
            },
            -- DAP configuration
            dap = {},
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
      "RRethy/vim-illuminate",
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
