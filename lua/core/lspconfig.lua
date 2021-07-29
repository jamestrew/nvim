local M = {}

M.config = function()
    local lspconf = require("lspconfig")

    local function on_attach(client, bufnr)
        require('lsp_signature').on_attach()  -- lsp signature
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits"}
    }

    local function setup_servers()
        require "lspinstall".setup()
        local servers = require "lspinstall".installed_servers()

        for _, lang in pairs(servers) do
            if lang == 'lua' then
                local luadev = require('lua-dev').setup({
                    lspconfig = {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                    version = 'LuaJIT',
                                    -- Setup your lua path
                                    path = vim.split(package.path, ';'),
                                },
                                diagnostics = {
                                    -- Get the language server to recognize the `vim` global
                                    globals = {'vim'},
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = {
                                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                                    },
                                    maxPreload = 100000,
                                    preloadFileSize = 100000
                                },
                                telemetry = {
                                    enable = false
                                },
                            }
                        }
                    }
                })
                lspconf[lang].setup(luadev)
            else
                lspconf[lang].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    root_dir = vim.loop.cwd
                }
            end
        end
    end

    setup_servers()

    -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
    require "lspinstall".post_install_hook = function()
        setup_servers() -- reload installed servers
        vim.cmd("bufdo e") -- triggers FileType autocmd that starts the server
    end

    -- replace the default lsp diagnostic letters with prettier symbols
    vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
    vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
    vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
end

return M
