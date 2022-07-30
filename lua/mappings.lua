local utils = require("utils")
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap
local silent = { silent = true }

local M = {}

vim.cmd([[command W :w]])
vim.cmd([[command Q :q]])
vim.cmd([[command Wq :wq]])

nnoremap("<CR>", ":nohl<CR>")

-- paste/delete and keep register clean
vnoremap("<leader>p", '"_dP')
vnoremap("<leader>d", '"_d')

-- better indenting
vnoremap("<", "<gv", silent)
vnoremap(">", ">gv", silent)

-- easier exit insert mode in the terminal
utils.tnoremap("<Esc>", "<C-\\><C-n>")

-- keeps jumps centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("<leader>J", "mzJ`z")

nnoremap("<leader>pp", ":echo expand('%:p')<CR>")
nnoremap("<leader>ss", require("utils").save_and_source)

nnoremap("<leader>fr", ":norm! V<CR> :s/") -- quick find & replace
vnoremap("<leader>fr", ":s/") -- quick find & replace

------------------------                  -------------------------
------------------------ Plugin Specifics -------------------------
------------------------                  -------------------------

-- Telescope
nnoremap("<C-p>", require("jtelescope").project_files)
nnoremap("<C-e>", ":Telescope file_browser<CR>", silent)
nnoremap("<leader><C-e>", ":Telescope file_browser path=%:p:h<CR>", silent)
nnoremap("<leader>fw", ":Telescope live_grep<CR>", silent)
nnoremap("<leader>gc", ":Telescope git_commits<CR>", silent)
nnoremap("<leader>fb", ":Telescope buffers<CR>", silent)
nnoremap("<leader>fh", ":Telescope help_tags<CR>", silent)
nnoremap("<leader>gw", ":Telescope grep_string<CR>", silent)
nnoremap("<leader>rc", require("jtelescope").search_dotfiles, silent)
nnoremap("<leader>fg", require("jtelescope").git_worktrees, silent)
nnoremap("<leader>ct", require("jtelescope").create_git_worktree, silent)
nnoremap("<leader>fy", require("jtelescope").neoclip, silent)
nnoremap("<leader>ff", require("jtelescope").curbuf, silent)
nnoremap("<leader>fc", ":Telescope commands<CR>", silent)
nnoremap("<leader>gh", require("jtelescope").git_hunks, silent)
nnoremap("<leader>vrc", require("jtelescope").search_dotfiles, silent)

M.lsp = function(bufnr)
  local opts = { silent = true, buffer = bufnr }
  nnoremap("gD", vim.lsp.buf.declaration, opts)
  nnoremap("K", vim.lsp.buf.hover, opts)
  nnoremap("<C-k>", vim.lsp.buf.signature_help, opts)
  nnoremap("<leader>D", vim.lsp.buf.type_definition, opts)
  nnoremap("<leader>rn", vim.lsp.buf.rename, opts)
  nnoremap("<leader>d", vim.diagnostic.open_float, opts)
  nnoremap("<leader>ca", vim.lsp.buf.code_action, opts)
  nnoremap("<leader>fm", function() vim.lsp.buf.format({ async = true }) end, opts)
  vnoremap("<leader>fm", vim.lsp.buf.range_formatting, opts)

  -- Lsp Tele
  nnoremap("gd", require("jtelescope").lsp_definition, opts)
  nnoremap("gr", require("jtelescope").lsp_reference, opts)
  nnoremap("<leader>gi", ":Telescope lsp_implementations<CR>", opts)
  nnoremap("<leader>fs", require("jtelescope").get_symbols, opts)
  nnoremap("<leader>td", ":Telescope diagnostics bufnr=0<CR>", opts)
  nnoremap("<leader>tw", ":Telescope diagnostics<CR>", opts)
end

-- Harpoon
nnoremap("<leader>a", require("harpoon.mark").add_file, silent)
nnoremap("<leader>e", function() require("harpoon.ui").toggle_quick_menu({ mark = true }) end, silent)
nnoremap("<leader>o", function() require("harpoon.ui").toggle_quick_menu({ mark = false }) end, silent)

nnoremap("<leader>hn", function() require("harpoon.ui").nav_file(1) end)
nnoremap("<leader>he", function() require("harpoon.ui").nav_file(2) end)
nnoremap("<leader>ho", function() require("harpoon.ui").nav_file(3) end)
nnoremap("<leader>hi", function() require("harpoon.ui").nav_file(4) end)

nnoremap("<leader>tn", function() require("harpoon.term").gotoTerminal(1) end)
nnoremap("<leader>te", function() require("harpoon.term").gotoTerminal(2) end)

-- git wrapper
nnoremap("<leader>gs", ":Neogit<CR>", silent)

-- Hop
nnoremap("<leader><leader>b", ":HopWordBC<CR>")
nnoremap("<leader><leader>w", ":HopWordAC<CR>")

-- undotree
nnoremap("<leader>u", ":UndotreeShow<CR>", silent)

-- symbols
nnoremap("<leader>so", ":SymbolsOutline<CR>", silent)

-- plenary
utils.nmap("<leader>pt", "<Plug>PlenaryTestFile")

return M
