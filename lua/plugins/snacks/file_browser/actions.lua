local Tree = require("snacks.explorer.tree")
local Actions = require("snacks.explorer.actions")

---@class jt.Action : snacks.picker.Action
---@field severity? number
---@field up? boolean

local uv = vim.uv or vim.loop

local M = {}

---@param picker snacks.Picker
---@param opts? {target?: boolean|string, refresh?: boolean}
function M.update(picker, opts)
  opts = opts or {}
  local cwd = picker:cwd()
  local target = type(opts.target) == "string" and opts.target or nil --[[@as string]]
  local refresh = opts.refresh or Tree:is_dirty(cwd, picker.opts)
  if target and not Tree:is_visible(cwd, target) then
    Tree:open(target)
    refresh = true
  end

  -- when searching, restore explorer view first
  if picker.input.filter.meta.searching then
    picker.input:set("", "")
    refresh = true
  end

  picker:set_cwd(target)
  if not refresh and target then
    -- return M.reveal(picker, target)
    picker:set_cwd(target)
  end
  if opts.target ~= false then picker.list:set_target() end
  picker:find({
    -- on_done = function()
    --   if target then M.reveal(picker, target) end
    -- end,
  })
end

---@class snacks.explorer.actions
---@field [string] snacks.picker.Action.spec
M.actions = {}

function M.actions.explorer_focus(picker)
  picker:set_cwd(picker:dir())
  picker:find()
end

function M.actions.explorer_up(picker)
  picker:set_cwd(vim.fs.dirname(picker:cwd()))
  picker:find()
end

function M.actions.explorer_paste(picker)
  local files = vim.split(vim.fn.getreg(vim.v.register or "+") or "", "\n", { plain = true })
  files = vim.tbl_filter(
    function(file) return file ~= "" and vim.fn.filereadable(file) == 1 end,
    files
  )

  if #files == 0 then
    return Snacks.notify.warn(
      ("The `%s` register does not contain any files"):format(vim.v.register or "+")
    )
  end
  local dir = picker:dir()
  Snacks.picker.util.copy(files, dir)
  Tree:refresh(dir)
  Tree:open(dir)
  M.update(picker, { target = dir })
end

---@param picker snacks.Picker
---@param item string
local function create(picker, item)
  if not item or item:find("^%s$") then return end
  local path = svim.fs.normalize(picker:dir() .. "/" .. item)
  local is_file = item:sub(-1) ~= "/"
  local dir = is_file and vim.fs.dirname(path) or path
  if is_file and uv.fs_stat(path) then
    Snacks.notify.warn("File already exists:\n- `" .. path .. "`")
    return
  end
  vim.fn.mkdir(dir, "p")
  if is_file then io.open(path, "w"):close() end
  Tree:open(dir)
  Tree:refresh(dir)
  M.update(picker, { target = path })
end

function M.actions.explorer_add(picker)
  Snacks.input({
    prompt = 'Add a new file or directory (directories end with a "/")',
  }, function(value) create(picker, value) end)
end

function M.actions.explorer_rename(picker, item)
  if not item then return end
  Snacks.rename.rename_file({
    from = item.file,
    on_rename = function(new, old)
      Tree:refresh(vim.fs.dirname(old))
      Tree:refresh(vim.fs.dirname(new))
      M.update(picker, { target = new })
    end,
  })
end

function M.actions.explorer_move(picker)
  ---@type string[]
  local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected())
  if #paths == 0 then
    Snacks.notify.warn("No files selected to move. Renaming instead.")
    return M.actions.explorer_rename(picker, picker:current())
  end
  local target = picker:dir()
  local what = #paths == 1 and vim.fn.fnamemodify(paths[1], ":p:~:.") or #paths .. " files"
  local t = vim.fn.fnamemodify(target, ":p:~:.")

  Actions.confirm("Move " .. what .. " to " .. t .. "?", function()
    for _, from in ipairs(paths) do
      local to = target .. "/" .. vim.fn.fnamemodify(from, ":t")
      Snacks.rename.rename_file({ from = from, to = to })
      Tree:refresh(vim.fs.dirname(from))
    end
    Tree:refresh(target)
    picker.list:set_selected() -- clear selection
    M.update(picker, { target = target })
  end)
end

function M.actions.explorer_copy(picker, item)
  if not item then return end
  ---@type string[]
  local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected())
  -- Copy selection
  if #paths > 0 then
    local dir = picker:dir()
    Snacks.picker.util.copy(paths, dir)
    picker.list:set_selected() -- clear selection
    Tree:refresh(dir)
    Tree:open(dir)
    M.update(picker, { target = dir })
    return
  end
  Snacks.input({
    prompt = "Copy to",
  }, function(value)
    if not value or value:find("^%s$") then return end
    local dir = vim.fs.dirname(item.file)
    local to = svim.fs.normalize(dir .. "/" .. value)
    if uv.fs_stat(to) then
      Snacks.notify.warn("File already exists:\n- `" .. to .. "`")
      return
    end
    Snacks.picker.util.copy_path(item.file, to)
    Tree:refresh(vim.fs.dirname(to))
    M.update(picker, { target = to })
  end)
end

function M.actions.explorer_del(picker)
  ---@type string[]
  local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected({ fallback = true }))
  if #paths == 0 then return end
  local what = #paths == 1 and vim.fn.fnamemodify(paths[1], ":p:~:.") or #paths .. " files"
  Actions.confirm("Delete " .. what .. "?", function()
    for _, path in ipairs(paths) do
      local ok, err = pcall(vim.fn.delete, path, "rf")
      if ok then
        Snacks.bufdelete({ file = path, force = true })
      else
        Snacks.notify.error("Failed to delete `" .. path .. "`:\n- " .. err)
      end
      Tree:refresh(vim.fs.dirname(path))
    end
    picker.list:set_selected() -- clear selection
    M.update(picker)
  end)
end

function M.actions.confirm(picker, item, action)
  if item.dir then
    M.update(picker, { target = item.file })
  elseif not item then
    create(picker, picker.input:get())
  else
    Snacks.picker.actions.jump(picker, item, action)
  end
end

return M
