local M = {}

local vertical_layout_big_preview = {
  layout = {
    backdrop = false,
    width = 0.5,
    min_width = 80,
    height = 0.8,
    min_height = 30,
    box = "vertical",
    border = "rounded",
    title = "{title} {live} {flags}",
    title_pos = "center",
    { win = "input", height = 1, border = "bottom" },
    { win = "list", border = "none" },
    { win = "preview", title = "{preview}", height = 0.7, border = "top" },
  },
}

local select_layout_small = {
  preview = false,
  layout = {
    backdrop = false,
    width = 0.35,
    min_width = 80,
    height = 0.4,
    min_height = 3,
    box = "vertical",
    border = "rounded",
    title = "{title}",
    title_pos = "center",
    { win = "input", height = 1, border = "bottom" },
    { win = "list", border = "none" },
    { win = "preview", title = "{preview}", height = 0.4, border = "top" },
  },
}

---@type snacks.picker.Config
M.defaults = {
  win = {
    -- input window
    input = {
      keys = {
        -- to close the picker on ESC instead of going to normal mode,
        -- add the following keymap to your config
        -- ["<Esc>"] = { "close", mode = { "n", "i" } },
        ["<Down>"] = { "history_forward", mode = { "i", "n" } },
        ["<Up>"] = { "history_back", mode = { "i", "n" } },
        ["<C-c>"] = { "cancel", mode = "i" },
        ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
        ["<CR>"] = { "confirm", mode = { "n", "i" } },
        ["<Esc>"] = "cancel",
        ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
        ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
        ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
        ["<a-d>"] = { "inspect", mode = { "n", "i" } },
        ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
        ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
        ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
        ["<c-a>"] = { "select_all", mode = { "n", "i" } },
        ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
        ["<c-n>"] = { "list_down", mode = { "i", "n" } },
        ["<c-p>"] = { "list_up", mode = { "i", "n" } },
        ["<c-q>"] = { "qflist", mode = { "i", "n" } },
        ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
        ["<c-t>"] = { "tab", mode = { "n", "i" } },
        ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },

        -- these actions crashes neovim?!?!
        ["<c-Left>"] = "layout_left",
        ["<c-Down>"] = "layout_bottom",
        ["<c-Up>"] = "layout_top",
        ["<c-Right>"] = "layout_right",

        ["?"] = "toggle_help_input",
        ["G"] = "list_bottom",
        ["gg"] = "list_top",
        ["j"] = "list_down",
        ["k"] = "list_up",
        ["q"] = "close",
      },
      b = {
        minipairs_disable = true,
      },
    },
  },

  enabled = true,
  db = {
    sqlite3_path = vim.fn.getenv("LIBSQLITE"),
  },

  sources = {
    explorer = {
      focus = "input",
      layout = "ivy",
      follow_file = false,
      auto_close = true,
      tree = false,
      hidden = true,
      on_close = function(picker)
        local Tree = require("snacks.explorer.tree")
        Tree:close_all(picker:cwd())
      end,
      win = {
        input = {
          keys = {
            ["<BS>"] = "explorer_up",
            -- ["h"] = "explorer_close", -- close directory
            ["<a-c>"] = "explorer_add",
            ["<a-d>"] = "explorer_del",
            ["<a-r>"] = "explorer_rename",
            -- ["c"] = "explorer_copy",
            ["<a-m>"] = "explorer_move",
            ["<a-o>"] = "explorer_open", -- open with system application
            ["<a-y>"] = { "explorer_yank", mode = { "n", "x" } },
            ["<a-p>"] = "explorer_paste",
            -- ["u"] = "explorer_update",
            ["<c-c>"] = "lcd",
            ["<a-g>"] = "picker_grep",
            ["<c-t>"] = "terminal",
            -- ["."] = "explorer_focus",
            -- ["I"] = "toggle_ignored",
            -- ["H"] = "toggle_hidden",
            -- ["Z"] = "explorer_close_all",
            -- ["]g"] = "explorer_git_next",
            -- ["[g"] = "explorer_git_prev",
            -- ["]d"] = "explorer_diagnostic_next",
            -- ["[d"] = "explorer_diagnostic_prev",
            -- ["]w"] = "explorer_warn_next",
            -- ["[w"] = "explorer_warn_prev",
            -- ["]e"] = "explorer_error_next",
            -- ["[e"] = "explorer_error_prev",
          },
        },
      },
    },
    treesitter = {
      filter = {
        default = {
          "Class",
          "Enum",
          "Field",
          "Function",
          "Method",
          "Module",
          "Namespace",
          "Struct",
          "Trait",
          "Constant",
          "Macro",
          "Var",
          "Variable",
        },
      },
    },
  },
}

M.file_browser = function(opts)
  opts = opts or {}
  opts = vim.tbl_deep_extend("force", opts, {
    layout = { preset = "ivy" },
    -- tree = false,
    follow_file = false,
  })
  Snacks.picker.explorer(opts)
end

M.buffers = function(opts)
  opts = opts or { layout = select_layout_small }
  Snacks.picker.buffers(opts)
end

---@type snacks.picker.lsp.Config
local lsp_defaults = {
  layout = vertical_layout_big_preview,
  include_current = true,
}

---@param opts snacks.picker.lsp.references.Config
M.lsp_references = function(opts)
  opts = opts or lsp_defaults
  Snacks.picker.lsp_references(opts)
end

---@param opts snacks.picker.lsp.Config
M.lsp_definitions = function(opts)
  opts = opts or lsp_defaults
  Snacks.picker.lsp_definitions(opts)
end

M.lsp_document_symbols = function(opts)
  opts = opts
    or {
      layout = { preset = "ivy" },
      filter = {
        default = {
          "Class",
          "Constant",
          "Constructor",
          "Enum",
          "Field",
          "Function",
          "Interface",
          "Method",
          "Module",
          "Namespace",
          "Object",
          "Package",
          "Property",
          "Struct",
          "Trait",
          "Variable",
        },
      },
    }
  Snacks.picker.lsp_symbols(opts)
end

M.testing = function()
  ---@type snacks.picker.Config
  local opts = {}
  return require("snacks.picker.core.picker").new(opts)
end

return M
