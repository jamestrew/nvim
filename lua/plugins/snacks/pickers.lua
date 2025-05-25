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

return M
