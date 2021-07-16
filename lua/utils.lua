-- for debuging
_G.dump = function(...)
    print(vim.inspect(...))
end

local M = {}

-- hide line numbers , statusline in specific buffers!
M.hideStuff = function()
    vim.api.nvim_exec(
        [[
   au BufEnter term://* setlocal nonumber
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
   au BufEnter term://* set laststatus=0 
]],
        false
    )
end


M.os = {
    home = os.getenv("HOME"),
    data = vim.fn.stdpath("data"),
    cache = vim.fn.stdpath("cache"),
    config = vim.fn.stdpath("config"),
    name = vim.loop.os_uname().sysname,
    is_git_dir = os.execute(
        'git rev-parse --is-inside-work-tree >> /dev/null 2>&1'
    ),
}

M.functions = {}

function M.execute(id)
    local func = M.functions[id]
    if not func then
        error("Function does not exist: " .. id)
    end
    return func()
end

-- mapping support
local map = function(mode, key, cmd, opts, defaults)
    opts = vim.tbl_deep_extend(
        "force", { silent = true }, defaults or {}, opts or {}
    )

    if type(cmd) == "function" then
        table.insert(M.functions, cmd)
        if opts.expr then
            cmd = ([[luaeval('require("util").execute(%d)')]]):format(#M.functions)
        else
            cmd = ("<cmd>lua require('utils').execute(%d)<cr>"):format(#M.functions)
        end
    end
    if opts.buffer ~= nil then
        local buffer = opts.buffer
        opts.buffer = nil
        return vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, opts)
    else
        return vim.api.nvim_set_keymap(mode, key, cmd, opts)
    end
end

function M.map(mode, key, cmd, opts, defaults)
    return map(mode, key, cmd, opts, defaults)
end

function M.nmap(key, cmd, opts) return map("n", key, cmd, opts) end
function M.vmap(key, cmd, opts) return map("v", key, cmd, opts) end
function M.xmap(key, cmd, opts) return map("x", key, cmd, opts) end
function M.imap(key, cmd, opts) return map("i", key, cmd, opts) end
function M.omap(key, cmd, opts) return map("o", key, cmd, opts) end
function M.smap(key, cmd, opts) return map("s", key, cmd, opts) end

function M.nnoremap(key, cmd, opts) return map("n", key, cmd, opts, { noremap = true }) end
function M.vnoremap(key, cmd, opts) return map("v", key, cmd, opts, { noremap = true }) end
function M.xnoremap(key, cmd, opts) return map("x", key, cmd, opts, { noremap = true }) end
function M.inoremap(key, cmd, opts) return map("i", key, cmd, opts, { noremap = true }) end
function M.onoremap(key, cmd, opts) return map("o", key, cmd, opts, { noremap = true }) end
function M.snoremap(key, cmd, opts) return map("s", key, cmd, opts, { noremap = true }) end


-- function M.error(msg, name)
--   M.log(msg, "LspDiagnosticsDefaultError", name)
-- end

return M
