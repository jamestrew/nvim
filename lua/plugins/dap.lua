local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  enabled = not Work,
}

function M.init()
  local utils = require("utils")
  local nnoremap = utils.nnoremap
  local silent = { silent = true }

  nnoremap("<F5>", require("dap").continue, silent)
  nnoremap("<F6>", require("dap").terminate, silent)
  nnoremap("<F2>", require("dap").step_into, silent)
  nnoremap("<F3>", require("dap").step_over, silent)
  nnoremap("<F4>", require("dap").step_out, silent)
  nnoremap("<leader>db", require("dap").toggle_breakpoint, silent)

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
  dap.adapters.go = {
    type = "executable",
    command = "node",
    args = { vim.fn.stdpath("data") .. "/mason/bin/go-debug-adapter" },
  }
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      showLog = false,
      program = "${file}",
      dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
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
