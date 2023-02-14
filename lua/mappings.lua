local utils = require("utils")
local nnoremap = utils.nnoremap
local vnoremap = utils.vnoremap
local silent = { silent = true }

local M = {}

local leaderkey = "<leader>"
local l = function(after) return string.format("%s%s", leaderkey, after) end
M.l = l


vim.cmd([[nmap <F1> <nop>]])
vim.cmd([[command W :w]])
vim.cmd([[command Q :q]])
vim.cmd([[command Wq :wq]])
vim.cmd([[command Wqa :wqa]])
vim.cmd([[command Qa :qa]])

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

-- symbols
nnoremap(l("so"), ":SymbolsOutline<CR>", silent)

-- plenary
utils.nmap(l("pt"), "<Plug>PlenaryTestFile")

-- DAP
if not Work then
  nnoremap("<F5>", require("dap").continue, silent)
  nnoremap("<F6>", require("dap").terminate, silent)
  nnoremap("<F2>", require("dap").step_into, silent)
  nnoremap("<F3>", require("dap").step_over, silent)
  nnoremap("<F4>", require("dap").step_out, silent)
  nnoremap(l("db"), require("dap").toggle_breakpoint, silent)
end

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


require("leap").add_default_mappings()

return M
