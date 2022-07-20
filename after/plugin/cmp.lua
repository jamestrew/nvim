local cmp = require("cmp")
local types = require("cmp.types")
local lspkind = require("lspkind")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local git_ok, git = pcall(require, "cmp_git")

if not git_ok and not Work then
  vim.notify("cmp_git not installed", vim.log.levels.WARN)
  return
end

local sources = {
  { name = "nvim_lsp" },
  { name = "path" },
  { name = "nvim_lua" },
  { name = "buffer", keyword_length = 3 },
  { name = "luasnip" },
  { name = "cmdline" },
  { name = "nvim_lsp_signature_help" },
}

if git_ok then
  table.insert(sources, { name = "git" })
  git.setup({
    filetypes = { "gitcommit", "NeogitCommitMessage" },
  })
end

local function deprioritize_snippet(entry1, entry2)
  if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return false
  end
  if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return true
  end
end

cmp.setup({
  formatting = {
    format = lspkind.cmp_format(),
  },
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  completion = {
    completeopt = "menuone,noselect",
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
  sorting = {
    priority_weight = 2,
    comparators = {
      deprioritize_snippet,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.scopes,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
