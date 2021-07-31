local M = {}

M.config = function()
    local gl = require("galaxyline")
    local gls = gl.section
    local condition = require("galaxyline.condition")

    gl.short_line_list = {" "}

    local global_theme = "themes/" .. vim.g.nvchad_theme
    local colors = require(global_theme)

    gls.left[1] = {
        FirstElement = {
            provider = function()
                return "▋"
            end,
            highlight = {colors.nord_blue, colors.nord_blue}
        }
    }

    gls.left[2] = {
        statusIcon = {
            provider = function()
                return "  "
            end,
            highlight = {colors.statusline_bg, colors.nord_blue},
            separator = "  ",
            separator_highlight = {colors.nord_blue, colors.lightbg}
        }
    }

    gls.left[3] = {
        FileIcon = {
            provider = "FileIcon",
            condition = condition.buffer_not_empty,
            highlight = {colors.white, colors.lightbg}
        }
    }

    gls.left[4] = {
        FileName = {
            provider = {"FileName"},
            condition = condition.buffer_not_empty,
            highlight = {colors.white, colors.lightbg},
            separator = " ",
            separator_highlight = {colors.lightbg, colors.lightbg2}
        }
    }

    gls.left[5] = {
        current_dir = {
            provider = function()
                local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                return "  " .. dir_name .. " "
            end,
            highlight = {colors.grey_fg2, colors.lightbg2},
            separator = " ",
            separator_highlight = {colors.lightbg2, colors.statusline_bg}
        }
    }

    local checkwidth = function()
        local squeeze_width = vim.fn.winwidth(0) / 2
        if squeeze_width > 30 then
            return true
        end
        return false
    end

    gls.left[6] = {
        DiffAdd = {
            provider = "DiffAdd",
            condition = checkwidth,
            icon = "  ",
            highlight = {colors.white, colors.statusline_bg}
        }
    }

    gls.left[7] = {
        DiffModified = {
            provider = "DiffModified",
            condition = checkwidth,
            icon = "  ",
            highlight = {colors.grey_fg2, colors.statusline_bg}
        }
    }

    gls.left[8] = {
        DiffRemove = {
            provider = "DiffRemove",
            condition = checkwidth,
            icon = "  ",
            highlight = {colors.grey_fg2, colors.statusline_bg}
        }
    }

    gls.left[9] = {
        DiagnosticError = {
            provider = "DiagnosticError",
            icon = "  ",
            highlight = {colors.red, colors.statusline_bg}
        }
    }

    gls.left[10] = {
        DiagnosticWarn = {
            provider = "DiagnosticWarn",
            icon = "  ",
            highlight = {colors.yellow, colors.statusline_bg}
        }
    }

    gls.left[11] = {
        DiagnosticInfo = {
            provider = "DiagnosticInfo",
            icon = "  ",
            highlight = {colors.green, colors.statusline_bg}
        }
    }

    gls.left[12] = {
        DiagnosticHint = {
            provider = "DiagnosticHint",
            icon = "  ",
            highlight = {colors.purple, colors.statusline_bg}
        }
    }

    -- RIGHT SIDE
    -- TODO: unsaved_cnt is kinda broken
    gls.right[1] = {
        unsaved = {
            provider = function()
                local unsaved_cnt = vim.api.nvim_eval(
                    [[len(getbufinfo({'bufmodified':1}))]]
                )
                if unsaved_cnt > 0 then
                    return "λ" .. unsaved_cnt
                end
            end,
            highlight = {colors.grey_fg2, colors.statusline_bg}
        }
    }

    gls.right[2] = {
        lsp_status = {
            provider = function()
                local clients = vim.lsp.get_active_clients()
                if next(clients) ~= nil then
                    return " " .. "  " .. " LSP "
                else
                    return ""
                end
            end,
            highlight = {colors.grey_fg2, colors.statusline_bg}
        }
    }

    gls.right[3] = {
        GitIcon = {
            provider = function()
                return " "
            end,
            condition = require("galaxyline.condition").check_git_workspace,
            highlight = {colors.grey_fg2, colors.statusline_bg},
            separator = " ",
            separator_highlight = {colors.statusline_bg, colors.statusline_bg}
        }
    }

    gls.right[4] = {
        GitBranch = {
            provider = "GitBranch",
            condition = require("galaxyline.condition").check_git_workspace,
            highlight = {colors.grey_fg2, colors.statusline_bg}
        }
    }

    gls.right[5] = {
        git_count = {
            provider = function()
                local stderr = {}
                local stdout, _ = require('plenary.job'):new({
                    command = "git",
                    args = {"diff-files"},
                    cwd = vim.fn.getcwd(),
                    on_stderr = function(_, data) table.insert(stderr, data) end
                }):sync()

                local count = 0
                for _ in pairs(stdout) do count = count + 1 end
                if count > 0 then
                    return "[" .. count .. "]"
                end
            end,
            event = "BufWritePost",
            highlight = {colors.grey_fg2, colors.statusline_bg}
        }
    }

    gls.right[6] = {
        viMode_icon = {
            provider = function()
                return " "
            end,
            highlight = {colors.statusline_bg, colors.red},
            separator = " ",
            separator_highlight = {colors.red, colors.statusline_bg}
        }
    }

    gls.right[7] = {
        ViMode = {
            provider = function()
                local alias = {
                    n = "Normal",
                    i = "Insert",
                    c = "Command",
                    V = "Visual",
                    [""] = "Visual",
                    v = "Visual",
                    R = "Replace"
                }
                local current_Mode = alias[vim.fn.mode()]

                if current_Mode == nil then
                    return "  Terminal "
                else
                    return "  " .. current_Mode .. " "
                end
            end,
            highlight = {colors.red, colors.lightbg}
        }
    }

    gls.right[8] = {
        some_icon = {
            provider = function()
                return " "
            end,
            separator = "",
            separator_highlight = {colors.green, colors.lightbg},
            highlight = {colors.lightbg, colors.green}
        }
    }

    gls.right[9] = {
        line_percentage = {
            provider = function()
                local current_line = vim.fn.line(".")
                local total_line = vim.fn.line("$")
                local current_col = vim.fn.virtcol('.')
                local details = current_line .. ":" .. current_col .. " "

                if current_line == 1 then
                    return "  Top " .. details
                elseif current_line == vim.fn.line("$") then
                    return "  Bot " .. details
                end
                local result, _ = math.modf((current_line / total_line) * 100)
                return "  " .. result .. "% " .. details
            end,
            highlight = {colors.green, colors.lightbg}
        }
    }
end
return M
