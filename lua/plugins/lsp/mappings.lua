local jtelescope = require("plugins.telescope.pickers")
local utils = require("utils")
local nnoremap = utils.nnoremap

return function(bufnr)
  local opts = { silent = true, buffer = bufnr }
  nnoremap("gD", vim.lsp.buf.declaration, opts)
  nnoremap("K", vim.lsp.buf.hover, opts)
  nnoremap("<C-k>", vim.lsp.buf.signature_help, opts)
  nnoremap("<leader>D", vim.lsp.buf.type_definition, opts)
  nnoremap("<leader>rn", vim.lsp.buf.rename, opts)
  nnoremap("<leader>od", vim.diagnostic.open_float, opts)
  nnoremap("<leader>ca", vim.lsp.buf.code_action, opts)
  nnoremap("<leader>fm", function() vim.lsp.buf.format({ async = true }) end, opts)

  -- Lsp Tele
  nnoremap("gd", jtelescope.lsp_definition, opts)
  nnoremap("<leader>gdv", function()
    vim.cmd.vsplit()
    jtelescope.lsp_definition()
  end, opts)
  nnoremap("<leader>gds", function()
    vim.cmd.split()
    jtelescope.lsp_definition()
  end, opts)
  nnoremap("gr", jtelescope.lsp_reference, opts)
  nnoremap("<leader>gi", ":Telescope lsp_implementations<CR>", opts)
  nnoremap("<leader>fs", jtelescope.get_symbols, opts)
  nnoremap("<leader>td", ":Telescope diagnostics bufnr=0<CR>", opts)
  nnoremap("<leader>tw", ":Telescope diagnostics<CR>", opts)
end
