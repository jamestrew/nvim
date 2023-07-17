local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  enabled = not Work,
}

M.keys = function()
  return {
    { "<F5>", require("dap").continue },
    { "<F6>", require("dap").terminate },
    { "<F2>", require("dap").step_into },
    { "<F3>", require("dap").step_over },
    { "<F4>", require("dap").step_out },
    { "<leader>db", require("dap").toggle_breakpoint },
  }
end

M.cmd = {
  "DapClearBreakpoints",
  "DapConditionalBreakpoints",
}

function M.init()
  vim.api.nvim_create_user_command(
    "DapClearBreakpoints",
    function() require("dap").clear_breakpoints() end,
    { desc = "Clear all DAP breakpoints" }
  )
  vim.api.nvim_create_user_command(
    "DapConditionalBreakpoints",
    function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    {}
  )
end

function M.config()
  local dap = require("dap")
  dap.adapters = {
    go = {
      type = "executable",
      command = "node",
      args = { vim.fn.stdpath("data") .. "/mason/bin/go-debug-adapter" },
    },
    lldb = {
      type = "executable",
      command = "lldb",
      args = { vim.fn.stdpath("data") .. "/mason/bin/codelldb" },
    },
  }
  dap.configurations = {
    go = {
      type = "go",
      name = "Debug",
      request = "launch",
      showLog = false,
      program = "${file}",
      dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
    },
    rust = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        initCommands = function()
          -- Find out where to look for the pretty printer Python module
          local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

          local script_import = 'command script import "'
            .. rustc_sysroot
            .. '/lib/rustlib/etc/lldb_lookup.py"'
          local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

          local commands = {}
          local file = io.open(commands_file, "r")
          if file then
            for line in file:lines() do
              table.insert(commands, line)
            end
            file:close()
          end
          table.insert(commands, 1, script_import)

          return commands
        end,
      },
    },
  }

  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })

  require("dap-go").setup()
  require("nvim-dap-virtual-text").setup({})

  local dapui = require("dapui")
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    vim.cmd("tabnew %")
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    vim.cmd("tabclose")
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    vim.cmd("tabclose")
    dapui.close()
  end
end

return M
