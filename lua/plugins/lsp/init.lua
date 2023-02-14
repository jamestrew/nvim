return {
  { "williamboman/mason.nvim", config = true },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "folke/neodev.nvim", config = true },
  { "b0o/SchemaStore.nvim" },
  {
    "simrat39/symbols-outline.nvim",
    opts = {
      position = "left",
      width = 40,
    },
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
