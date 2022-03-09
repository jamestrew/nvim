local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = "menuone,noselect",
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "buffer", keyword_length = 3 },
    { name = "luasnip" },
    { name = "cmp_git" },
    { name = "cmdline" },
    { name = "nvim_lsp_signature_help" },
  },
})

require("cmp_git").setup({
  filetypes = { "gitcommit", "NeogitCommitMessage" }
})
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  sources = {
    { name = "cmdline" },
  },
})
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
