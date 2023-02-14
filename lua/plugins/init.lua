return {
  { "nvim-lua/plenary.nvim" },

  { "thePrimeagen/harpoon" },

  -- Looks
  { "feline-nvim/feline.nvim" },
  { "tjdevries/colorbuddy.vim" },
  { "stevearc/dressing.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "folke/noice.nvim" },

  -- Others
  { "kkharji/sqlite.lua", enabled = not Work },
  { "nathom/filetype.nvim" },
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
