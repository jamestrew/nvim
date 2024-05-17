if vim.fn.executable("tree-sitter-grammar-lsp-linux") == 1 then
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = { "grammar.js", "*/corpus/*.txt" },
    callback = function()
      vim.lsp.start({
        name = "tree-sitter-grammar-lsp",
        cmd = { "tree-sitter-grammar-lsp-linux" },
        root_dir = "~/projects/nvim-docgen",
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = require("plugins.lsp").on_attach,
      })
    end,
  })
end
