local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
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
          { path = "snacks.nvim", words = { "Snacks" } },
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
          local os = vim.uv.os_uname().sysname
          local ext = os == "Linux" and "so" or "dylib"
          ---@diagnostic disable-next-line: param-type-mismatch
          local mason_path = vim.fs.joinpath(vim.fn.stdpath("data"), "/mason")
          local ext_path = vim.fs.joinpath(mason_path, "packages", "codelldb", "extension")
          local codelldb_path = vim.fs.joinpath(ext_path, "adapter", "codelldb")
          local liblldb_path = vim.fs.joinpath(ext_path, "lldb", "lib", "liblldb." .. ext)

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
              default_settings = {
                ["rust-analyzer"] = {
                  completion = {
                    callable = { snippets = "fill_arguments" },
                    fullFunctionSignatures = { enable = true },
                  },
                  procMacro = { enable = true },
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
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
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
      enabled = false,
    },
    {
      "oskarrrrrrr/symbols.nvim",
      config = function()
        local r = require("symbols.recipes")
        require("symbols").setup(r.DefaultFilters, r.AsciiSymbols, {
          -- custom settings here
          -- e.g. hide_cursor = false
        })
      end,
      keys = { { "<leader>so", "<cmd>Symbols<CR>", desc = "symbols-outline" } },
    },
    {
      "RRethy/vim-illuminate",
      config = function() require("illuminate").configure({}) end,
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  init = function() vim.api.nvim_create_augroup("lsp_augroup", { clear = true }) end,
  config = function()
    local lsputils = require("plugins.lsp.utils")

    -- local capabilities = require("blink.cmp").get_lsp_capabilities()
    -- vim.lsp.config("*", {
    --   capabilities = capabilities,
    -- })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        lsputils.on_attach(client, bufnr)
      end,
      group = "lsp_augroup",
    })

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

    local lsp_ns = vim.api.nvim_create_namespace("lsp_ns")
    vim.api.nvim_set_hl(lsp_ns, "LspReferenceText", { link = "CursorLine" })
    vim.api.nvim_set_hl(lsp_ns, "LspReferenceWrite", { link = "CursorLine" })
    vim.api.nvim_set_hl(lsp_ns, "LspReferenceRead", { link = "CursorLine" })

    local server_list = {
      "cssls",
      -- "sqls",
      -- "pyright",
      "basedpyright",
      "ruff",
      -- "eslint",
      "emmet_language_server",
      "html",
      "lua_ls",
      "jsonls",
      "gopls",
      "bashls",
      -- "ts_ls",
      "biome",
      "clangd",
      "taplo", -- toml
      -- "rust_analyzer",
      -- "denols",
      "nil_ls",

      -- "ts_query_ls"
      "tailwindcss",
    }

    for _, server in ipairs(server_list) do
      vim.lsp.enable(server, true)
    end
  end,
}

return M
