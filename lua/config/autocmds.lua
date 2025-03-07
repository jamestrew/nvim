local my_augroup = vim.api.nvim_create_augroup("my_augroup", { clear = true })

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "lspinfo", "fugitive", "qf" },
  command = "nnoremap <buffer><silent> q :quit<CR>",
  group = my_augroup,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank()",
  group = my_augroup,
})

-- remove whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
  group = my_augroup,
})

local ns = vim.api.nvim_create_namespace("terminal_prompt_markers")
vim.api.nvim_create_autocmd("TermRequest", {
  callback = function(args)
    if string.match(args.data.sequence, "^\027]133;A") then
      local lnum = args.data.cursor[1]
      vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
        -- Replace with sign text and highlight group of choice
        sign_text = "▶",
        sign_hl_group = "SpecialChar",
      })
    end
  end,
})

-- Enable signcolumn in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  command = "setlocal signcolumn=auto",
})
