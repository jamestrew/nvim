-- Run from dots/nvim: nvim --headless -u NONE -l test/copilot_blink.lua
vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/blink.cmp")

local menu_open, copilot_visible, blink_handles = false, false, true
local calls = {}
local function record(action) calls[#calls + 1] = action end
local suggestion = {
  is_visible = function() return copilot_visible end,
  update_preview = function() record("preview") end,
}
for _, action in ipairs({ "accept", "next", "prev" }) do
  suggestion[action] = function() record("copilot:" .. action) end
end
package.loaded["copilot.suggestion"] = suggestion

local cmp = { is_menu_visible = function() return menu_open end }
for _, action in ipairs({ "select_and_accept", "select_next", "select_prev" }) do
  cmp[action] = function()
    if menu_open and blink_handles then
      record("blink:" .. action)
      return true
    end
  end
end
package.loaded["blink.cmp"] = cmp
package.loaded["blink.cmp.config"] = { enabled = function() return true end }
package.loaded["blink.cmp.keymap.fallback"] = {
  wrap = function(_, key)
    return function(mappings_only) record("fallback:" .. key .. ":" .. tostring(mappings_only)) end
  end,
}

local keymaps = dofile("lua/plugins/blink.lua").opts.keymap
local bindings = {
  { "<c-y>", "select_and_accept", "accept", false },
  { "<c-n>", "select_next", "next", true },
  { "<c-p>", "select_prev", "prev", true },
}
local shared_keymaps = {}
for _, binding in ipairs(bindings) do
  shared_keymaps[binding[1]] = keymaps[binding[1]]
end
require("blink.cmp.keymap.apply").keymap_to_current_buffer(shared_keymaps)

local function press(key, expected)
  calls = {}
  vim.fn.maparg(key, "i", false, true).callback()
  assert(vim.deep_equal(calls, { expected }), vim.inspect(calls))
end

for _, binding in ipairs(bindings) do
  local key, blink_action, copilot_action, mappings_only = unpack(binding)
  local fallback = "fallback:" .. key .. ":" .. tostring(mappings_only)
  menu_open, copilot_visible, blink_handles = true, true, true
  press(key, "blink:" .. blink_action)
  blink_handles = false -- Even if Blink declines, never act on Copilot under its menu.
  press(key, fallback)
  menu_open = false
  press(key, "copilot:" .. copilot_action)
  copilot_visible = false
  press(key, fallback)
  package.loaded["copilot.suggestion"] = nil
  press(key, fallback)
  package.loaded["copilot.suggestion"] = suggestion
end

local copilot = dofile("lua/plugins/ai.lua")[1]
assert(copilot.opts.suggestion.keymap.accept == "<M-l>")
assert(copilot.opts.suggestion.keymap.next == "<M-n>")
copilot.init()
copilot.init() -- Reloading must not register duplicate callbacks.
for _, event in ipairs({ "BlinkCmpMenuOpen", "BlinkCmpMenuClose" }) do
  calls = {}
  vim.api.nvim_exec_autocmds("User", { pattern = event })
  assert(vim.b.copilot_suggestion_hidden == (event == "BlinkCmpMenuOpen"))
  assert(vim.deep_equal(calls, { "preview" }))
end
package.loaded["copilot.suggestion"] = nil
vim.api.nvim_exec_autocmds("User", { pattern = "BlinkCmpMenuOpen" })
assert(vim.b.copilot_suggestion_hidden == true)

print("Copilot/Blink mappings and visibility: OK")
