return {
  { "nvim-lua/plenary.nvim" },
  { "nathom/filetype.nvim" },
  { "samjwill/nvim-unception" },
  { "andweeb/presence.nvim", config = true, enabled = not Work },
  { "mrjones2014/smart-splits.nvim", config = true },
  { "AckslD/messages.nvim", config = true },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    opts = { app = "browser" },
    enabled = not Work,
  },
  {
    "thePrimeagen/harpoon",
    opts = {
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        mark_branch = not Work,
        excluded_filetypes = { "harpoon", "TelescopePrompt" },
      },
    },
  },
}
