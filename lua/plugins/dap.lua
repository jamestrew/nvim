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
    { "<leader>bp", require("dap").toggle_breakpoint },
  }
end

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

  local debug_tab = nil

  local function open_debug_tab()
    if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
      vim.api.nvim_set_current_tabpage(debug_tab)
      return
    end

    vim.cmd("tabnew %")
    debug_tab = vim.api.nvim_get_current_tabpage()
    dapui.open()
  end

  local function close_debug_tab()
    dapui.close()
    if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
      vim.api.nvim_exec2("tabclose " .. vim.api.nvim_tabpage_get_number(debug_tab), {})
    end
    debug_tab = nil
  end

  dap.listeners.before.attach.dapui_config = function() open_debug_tab() end
  dap.listeners.before.launch.dapui_config = function() open_debug_tab() end
  dap.listeners.before.event_terminated.dapui_config = function() close_debug_tab() end
  dap.listeners.before.event_exited.dapui_config = function() close_debug_tab() end
end

return M
