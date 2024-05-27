---@diagnostic disable: missing-fields
local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "onsails/lspkind-nvim" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip", version = "2.*", run = "make install_jsregexp" },
    { "rafamadriz/friendly-snippets" },
    { "petertriho/cmp-git" },
    {
      "zbirenbaum/copilot-cmp",
      dependencies = { "zbirenbaum/copilot.lua" },
      opts = {},
    },
    {
      "saecki/crates.nvim",
      dependencies = { "nvimtools/none-ls.nvim" },
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },
}

M.config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")

  local sources = {
    { name = "nvim_lsp" },
    -- { name = "copilot" },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "buffer", keyword_length = 3 },
    { name = "luasnip" },
  }

  local git_ok, git = pcall(require, "cmp_git")
  if git_ok then
    table.insert(sources, { name = "git" })
    git.setup({
      filetypes = { "gitcommit", "NeogitCommitMessage" },
    })
  end

  local crates_ok, crates = pcall(require, "crates")
  if crates_ok then
    table.insert(sources, { name = "crates" })
    crates.setup({ null_ls = { enabled = true } })
  end

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    formatting = {
      format = lspkind.cmp_format(),
    },
    snippet = {
      expand = function(args) require("luasnip").lsp_expand(args.body) end,
    },
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    }),
    sources = cmp.config.sources(sources),
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path", keyword_length = 2 },
      { name = "cmdline", keyword_length = 2 },
    }),
  })
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

  -- luasnip
  local luasnip = require("luasnip")
  luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  })

  local silent = { silent = true }
  vim.keymap.set({ "i", "s" }, "<C-k>", function() luasnip.expand_or_jump() end, silent)
  vim.keymap.set({ "i", "s" }, "<C-j>", function() luasnip.jump(-1) end, silent)
  vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if luasnip.choice_active() then luasnip.change_choice(1) end
  end, silent)

  require("luasnip.loaders.from_vscode").lazy_load()
end

return M
