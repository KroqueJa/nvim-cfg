-- Ensure DAP installed
local dap_ok, dap = pcall(require, "dap")
if not (dap_ok) then
    print("nvim-dap not installed!")
    return
end

-- require('dap').set_log_level('DEBUG') -- Helps when configuring DAP, see logs with :DapShowLog
require('dapui').setup()

-- Mason setup
-- Virtual text shows at end of line
require("nvim-dap-virtual-text").setup({virt_text_pos = 'eol'})

-- TODO: move out of here
require("mason-nvim-dap").setup({
    ensure_installed = {"codelldb"}
})

-- Search for running process
local function filtered_pick_process()
    local opts = {}
    vim.ui.input({
        prompt = "Search by process name (lua pattern), or hit enter to select from the process list: "
    }, function(input) opts["filter"] = input or "" end)
    return require("dap.utils").pick_process(opts)
end

--------------------
-- Setup adaptors --
--------------------

dap.adapters["lldb-dap"] = {
    type = 'server',
    port = "${port}",
    executable = {
        command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
        args = {'--port', "${port}"}
    }
}

--------------------------
-- Setup configurations --
--------------------------

-- Function to run dsymutil
local program
local function runDsymutil(executable)
    local handle = io.popen('dsymutil ' .. executable)
    if handle ~= nil then
        local result = handle:read("*a")
        print(result)
        handle:close()
    end
end

dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "lldb-dap",
        request = "launch",
        program = function()
            program = vim.fn.input('Path to executable: ',
            vim.fn.getcwd() .. '/', 'file')
            return program
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false
    }, {
        name = "Debug with Args",
        type = "lldb-dap",
        request = "launch",
        program = function()
            program = vim.fn.input('Path to executable: ',
            vim.fn.getcwd() .. '/', 'file')
            return program
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local args_str = vim.fn.input('Program arguments: ')
            return vim.split(args_str, " +")
        end
    }, {
        name = "Attach",
        type = "lldb-dap",
        request = "attach",
        pid = filtered_pick_process,
        stopOnEntry = false
    }, {
        name = "Attach to Name (wait)",
        type = "lldb-dap",
        stopOnEntry = false,
        request = "attach",
        program = function()
            program = vim.fn.input('Path to executable: ',
            vim.fn.getcwd() .. '/', 'file')
            return program
        end,
        waitFor = true
    }
}

-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

--------------------------
-- Setup start and stop --
--------------------------

-- Setup event listener to start dapui
dap.listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open({})
    vim.o.mouse = "a"
end

-- Setup close function for dapui
_G.Dapui_terminate = function()
    local dap = require("dap")
    local dapui = require("dapui")

    if dap.session() then
        dap.terminate()
        dap.disconnect()
    end
    dapui.close()
    vim.o.mouse = ""
end

return M
