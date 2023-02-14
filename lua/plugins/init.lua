return {
  { "nvim-lua/plenary.nvim" },

  { "thePrimeagen/harpoon" },

  -- Looks
  { "feline-nvim/feline.nvim" },
  { "tjdevries/colorbuddy.vim" },
  { "onsails/lspkind-nvim" },
  { "stevearc/dressing.nvim" },
  { "levouh/tint.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "folke/noice.nvim" },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
        indicator = { style = "underline" },
        always_show_bufferline = false,
      },
    },
  },

  -- Others
  { "kkharji/sqlite.lua", enabled = not Work },
  { "nathom/filetype.nvim" },
  { "j-hui/fidget.nvim" },
  { "petertriho/nvim-scrollbar" },
  { "andweeb/presence.nvim", enabled = not Work },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    opts = { app = "browser" },
    enabled = not Work,
  },
  { "mrjones2014/smart-splits.nvim" },
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { "kristijanhusak/vim-dadbod-completion" },
  { "samjwill/nvim-unception" },
  { "AckslD/messages.nvim" },
}
