local diagnostic = require("hover.providers.diagnostic")

local function code_blocks(message)
  local lines = vim.split(message, "\n")
  local fenced = false
  for i, line in ipairs(lines) do
    if line:match("^%s*```") then
      fenced = not fenced
    elseif not fenced then
      -- PrettyTsFormat leaves single-line types inline, even when truncated and huge.
      lines[i] = line:gsub(
        "`([^`]+)`",
        function(code) return "\n```typescript\n" .. code .. "\n```\n" end
      )
    end
  end
  return table.concat(lines, "\n")
end

return {
  name = diagnostic.name,
  priority = diagnostic.priority,
  enabled = diagnostic.enabled,
  execute = function(params, done)
    local ft = vim.bo[params.bufnr].filetype
    if ft ~= "typescript" and ft ~= "typescriptreact" then
      return diagnostic.execute(params, done)
    end

    local float = vim.diagnostic.config().float
    float = type(float) == "table" and float or {}
    local scope = float.scope or "line"
    local opts = {}
    if scope == "line" or scope == "l" then
      opts.lnum = params.pos[1] - 1
    elseif scope == "cursor" or scope == "c" then
      opts.pos = { params.pos[1] - 1, params.pos[2] }
    end
    local diagnostics = vim.diagnostic.get(params.bufnr, opts)
    if float.severity_sort then
      local reverse = type(float.severity_sort) == "table" and float.severity_sort.reverse
      table.sort(diagnostics, function(a, b)
        if reverse then return a.severity > b.severity end
        return a.severity < b.severity
      end)
    end

    local lines = {}
    for _, d in ipairs(diagnostics) do
      local message = d.message
      local ok, formatted = pcall(vim.fn.PrettyTsFormat, message)
      if ok and type(formatted) == "string" and formatted ~= "" then
        message = code_blocks(formatted)
      end

      if #lines > 0 then table.insert(lines, "") end
      local heading = vim.diagnostic.severity[d.severity]
      if d.source then heading = heading .. " · " .. d.source end
      if d.code then heading = heading .. " [" .. d.code .. "]" end
      table.insert(lines, "**" .. heading .. "**")
      table.insert(lines, "")
      vim.list_extend(lines, vim.split(message, "\n"))
    end

    if #lines == 0 then return done() end
    done({ lines = lines, filetype = "markdown" })
  end,
}
