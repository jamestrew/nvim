local import = require("utils").import

local dap = import("dap")

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

import("dap-go", {})
import("nvim-dap-virtual-text", {})
local dapui = import("dapui", {})

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
