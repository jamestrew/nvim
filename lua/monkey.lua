vim.filetype.add({
  extension = {
    mon = "monkey",
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.monkey = {
  install_info = {
    url = "~/projects/archive/tree-sitter-monkey", -- local path or git repo
    files = { "src/parser.c" },
    -- optional entries:
    branch = "master", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "monkey", -- if filetype does not match the parser name
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "monkey",
  callback = function()
    vim.lsp.start({
      name = "monkey-language-server",
      cmd = { "/home/jt/projects/monkey-language-server/target/release/monkey-language-server" },
    })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    require("plugins.lsp").on_attach(client, ev.buf)
  end,
})
