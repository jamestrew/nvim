local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "jbyuki/one-small-step-for-vimkind",
  },
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

  vim.api.nvim_create_user_command(
    "DapOSVLaunch",
    function() require("osv").launch({ port = 8086 }) end,
    {}
  )
end

function M.config()
  local dap = require("dap")
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

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
