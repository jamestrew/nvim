local opt = vim.opt

opt.termguicolors = true -- totally borks the entire config without it
opt.laststatus = 3 -- one global statusline as oppose to many during splits

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

opt.wildmode = { "longest", "list", "full" }

-- Cool floating window popup menu for completion on command line
opt.pumblend = 0

opt.wildmode = opt.wildmode - "list"
opt.wildmode = opt.wildmode + { "longest", "full" }

opt.wildoptions = "pum"

opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar
opt.signcolumn = "yes" -- Leave extra space in the gutter (for git signs, etc.)
opt.incsearch = true -- Makes search act like search in modern browsers
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.hidden = true -- I like having buffers stay around
opt.cursorline = true -- Highlight the current line
opt.equalalways = true -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.updatetime = 200 -- Make updates happen faster
opt.hlsearch = false -- Get rid of highlights once done with search
opt.scrolloff = 15 -- Make it so there are always ten lines below my cursor

-- Tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.colorcolumn = "80"

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"
opt.shell = "/bin/zsh"
opt.undofile = true

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }

vim.api.nvim_create_augroup("my_config", { clear = true })

-- windows to close with "q"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man", "lspinfo", "fugitive", "qf" },
  command = "nnoremap <buffer><silent> q :quit<CR>",
  group = "my_config",
})

-- get rid of weird formatoptions
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "setlocal formatoptions-=r formatoptions-=o",
  group = "my_config",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  command = "silent! lua vim.highlight.on_yank()",
  group = "my_config",
})

-- autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
  group = "my_config",
})
