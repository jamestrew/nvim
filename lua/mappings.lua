local utils = require("utils")
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap
local silent = { silent = true }

local leaderkey = "<leader>"
local l = function(after) return string.format("%s%s", leaderkey, after) end

local M = {}

vim.cmd([[nmap <F1> <nop>]])
vim.cmd([[command W :w]])
vim.cmd([[command Q :q]])
vim.cmd([[command Wq :wq]])
vim.cmd([[command Wqa :wqa]])
vim.cmd([[command Qa :qa]])

nnoremap("<CR>", ":nohl<CR>")

-- paste/delete and keep register clean
vnoremap(l("p"), '"_dP')
vnoremap(l("d"), '"_d')
nnoremap(l("dd"), '"_d')

-- better indenting
vnoremap("<", "<gv", silent)
vnoremap(">", ">gv", silent)

-- easier exit insert mode in the terminal
utils.tnoremap("<Esc>", "<C-\\><C-n>")

-- keeps jumps centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap(l("J"), "mzJ`z")

nnoremap(l("pp"), ":echo expand('%:p')<CR>")
nnoremap(l("ss"), require("utils").save_and_source)

nnoremap(l("fr"), ":norm! V<CR> :s/") -- quick find & replace
vnoremap(l("fr"), ":s/") -- quick find & replace

nnoremap(l("rs"), utils.rsync_work_files)

------------------------                  -------------------------
------------------------ Plugin Specifics -------------------------
------------------------                  -------------------------

-- Telescope
nnoremap("<C-p>", require("jtelescope").project_files)
nnoremap(l("<C-p>"), function() require("jtelescope").project_files({}, true) end)
nnoremap("<C-e>", ":Telescope file_browser<CR>", silent)
nnoremap(l("<C-e>"), ":Telescope file_browser path=%:p:h<CR>", silent)
nnoremap(l("fw"), ":Telescope live_grep<CR>", silent)
nnoremap(l(l("fw")), require("telescope").extensions.live_grep_args.live_grep_args, silent)
nnoremap(l("gf"), require("jtelescope").live_grep_file, silent)
nnoremap(l("gc"), ":Telescope git_commits<CR>", silent)
nnoremap(l("fb"), ":Telescope buffers<CR>", silent)
nnoremap(l("fh"), ":Telescope help_tags<CR>", silent)
nnoremap(l("gw"), ":Telescope grep_string<CR>", silent)
nnoremap(l("rc"), require("jtelescope").search_dotfiles, silent)
nnoremap(l("fg"), require("jtelescope").git_worktrees, silent)
nnoremap(l("ct"), require("jtelescope").create_git_worktree, silent)
nnoremap(l("fy"), require("jtelescope").neoclip, silent)
nnoremap(l("ff"), require("jtelescope").curbuf, silent)
nnoremap(l("fc"), ":Telescope commands<CR>", silent)
nnoremap(l("gh"), require("jtelescope").git_hunks, silent)
nnoremap(l("vrc"), require("jtelescope").search_dotfiles, silent)

M.lsp = function(bufnr)
  local opts = { silent = true, buffer = bufnr }
  nnoremap("gD", vim.lsp.buf.declaration, opts)
  nnoremap("K", vim.lsp.buf.hover, opts)
  nnoremap("<C-k>", vim.lsp.buf.signature_help, opts)
  nnoremap(l("D"), vim.lsp.buf.type_definition, opts)
  nnoremap(l("rn"), vim.lsp.buf.rename, opts)
  nnoremap(l("od"), vim.diagnostic.open_float, opts)
  nnoremap(l("ca"), vim.lsp.buf.code_action, opts)
  nnoremap(l("fm"), function() vim.lsp.buf.format({ async = true }) end, opts)

  -- Lsp Tele
  nnoremap("gd", require("jtelescope").lsp_definition, opts)
  nnoremap("gr", require("jtelescope").lsp_reference, opts)
  nnoremap(l("gi"), ":Telescope lsp_implementations<CR>", opts)
  nnoremap(l("fs"), require("jtelescope").get_symbols, opts)
  nnoremap(l("td"), ":Telescope diagnostics bufnr=0<CR>", opts)
  nnoremap(l("tw"), ":Telescope diagnostics<CR>", opts)
end

-- Harpoon
nnoremap("<leader>a", require("harpoon.mark").add_file, silent)
nnoremap(l("e"), function() require("harpoon.ui").toggle_quick_menu() end, silent)

nnoremap(l("hn"), function() require("harpoon.ui").nav_file(1) end)
nnoremap(l("he"), function() require("harpoon.ui").nav_file(2) end)
nnoremap(l("ho"), function() require("harpoon.ui").nav_file(3) end)
nnoremap(l("hi"), function() require("harpoon.ui").nav_file(4) end)

nnoremap(l("tn"), function() require("harpoon.term").gotoTerminal(1) end)
nnoremap(l("te"), function() require("harpoon.term").gotoTerminal(2) end)

-- git wrapper
nnoremap(l("gs"), require("neogit").open, silent)

-- Hop
nnoremap(l(l("b")), ":HopWordBC<CR>")
nnoremap(l(l("w")), ":HopWordAC<CR>")

-- undotree
nnoremap(l("u"), ":UndotreeShow<CR>", silent)

-- symbols
nnoremap(l("so"), ":SymbolsOutline<CR>", silent)

-- plenary
utils.nmap(l("pt"), "<Plug>PlenaryTestFile")

-- DAP
nnoremap("<F5>", require("dap").continue, silent)
nnoremap("<F6>", require("dap").terminate, silent)
nnoremap("<F2>", require("dap").step_into, silent)
nnoremap("<F3>", require("dap").step_over, silent)
nnoremap("<F4>", require("dap").step_out, silent)
nnoremap(l("db"), require("dap").toggle_breakpoint, silent)

M.gitsigns = function(bufnr)
  local opts = { silent = true, buffer = bufnr }
  local gs = require("gitsigns")
  nnoremap(l("hs"), gs.stage_hunk, opts)
  nnoremap(l("hu"), gs.undo_stage_hunk, opts)
  nnoremap(l("hp"), gs.preview_hunk, opts)
  nnoremap(l("hb"), gs.blame_line, opts)
  nnoremap(l("hr"), gs.reset_hunk, opts)

  vnoremap(l("hs"), ":Gitsigns stage_hunk<CR>", opts)
  vnoremap(l("hr"), ":Gitsigns reset_hunk<CR>", opts)
end

-- smart split
nnoremap(l("sp"), require("smart-splits").start_resize_mode, silent)

nnoremap(l("tb"), require("typebreak").start)

require("leap").add_default_mappings()

return M
