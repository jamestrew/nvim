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
    require("nvim-treesitter").install({
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
    })
    vim.cmd(":TSUpdate")
  end,
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(ev)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.fs.normalize(ev.file))
        if ok and stats and stats.size < max_filesize then vim.treesitter.start() end
      end,
    })

    vim.treesitter.language.register("bash", "zsh")
  end,
}
