return {
  { "williamboman/mason.nvim", config = true },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "folke/neodev.nvim", config = true },
  { "b0o/SchemaStore.nvim" },
  {
    "simrat39/symbols-outline.nvim",
    opts = {
      position = "left",
      relative_width = false,
      width = 40,
    },
    keys = { "<leader>so", ":SymbolsOutline<CR>", desc = "symbols-outline" },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function() require("plugins.lsp.setup")() end,
  },
}
