local parsers = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "graphql",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
  "lua",
  "luadoc",
  "make",
  "python",
  "query",
  "rust",
  "scss",
  "sql",
  "tsx",
  "svelte",
  "typescript",
  "vim",
  "yaml",
  "toml",
  "markdown",
  "markdown_inline",
  "regex",
  "vimdoc",
  "nix",
  "fish",
  "gitcommit",
  "git_rebase",
  "git_config",
  "gitignore",
  "gitattributes",
  "diff",
  "zig",
}

local patterns = vim.list_extend(parsers, {
  "javascriptreact",
  "typescriptreact",
  "zsh",
})

return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {},
      enabled = false, -- useful but sometimes the context is huge and takes up a ton of space
    },
    { "andymass/vim-matchup" },
  },
  branch = "main",
  build = function()
    require("nvim-treesitter").install(parsers)
    vim.cmd(":TSUpdate")
  end,
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = patterns,
      callback = function(ev)
        local max_filesize = 500 * 1024 -- 500 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.fs.normalize(ev.file))
        if ok and stats and stats.size < max_filesize then
          vim.bo[ev.buf].syntax = "on" -- Use regex based syntax-highlighting as fallback as some plugins might need it
          vim.wo.foldlevel = 99
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folds
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Use treesitter for indentation
          vim.treesitter.start(ev.buf)
        end
      end,
    })

    vim.treesitter.language.register("bash", "zsh")
  end,
}
