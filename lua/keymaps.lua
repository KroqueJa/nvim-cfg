-- Helper function to make the file a little less verbose
local function mapkey(mode, key, cmd)
    vim.api.nvim_set_keymap(mode, key, cmd, {noremap = true, silent = true})
end

-- Normal mode
local function nmapkey(key, cmd)
    mapkey('n', key, cmd, {noremap = true, silent = true})
end

-- ======== Unsorted keybinds ========
-- Auto-align file
nmapkey('<leader>A', 'ggVG=')

-- ======== Flash ========
-- Flash jump
mapkey('n', 'ss', '<cmd>lua require("flash").jump()<CR>')
mapkey('x', 'ss', '<cmd>lua require("flash").jump()<CR>')
mapkey('o', 'ss', '<cmd>lua require("flash").jump()<CR>')

-- Ctrl+q to toggle Neo-tree
nmapkey('<C-q>', ':Neotree toggle<CR>')

-- ======== LSP ========
-- Hover
nmapkey('K', '<cmd>lua vim.lsp.buf.hover()<CR>')

-- leader+F to auto-apply formatter/linter
nmapkey('<leader>F', '<cmd>lua vim.lsp.buf.format()<CR>')

-- Diagnostics are prefixed with 'd'
-- `d`iagnostic `n`ext
nmapkey('<leader>gdn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
-- `d`iagnostic `p`revious
nmapkey('<leader>gdp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- `d`iagnostic <K is for hover>
nmapkey('<leader>dK', '<cmd>lua vim.diagnostic.open_float()<CR>')

-- `c`ode `a`ctions
nmapkey('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

-- `c`ode `r`efactor
vim.keymap.set('n', '<leader>cr',
               function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
               {expr = true, noremap = true, silent = true})

-- `g`o `d`efinition
nmapkey('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')

-- `g`o `i`mplementation
nmapkey('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

-- `g`o `r`eferences
nmapkey('gr', '<cmd>lua vim.lsp.buf.references()<CR>')

-- ======== Surround ========

-- Select word quickly
-- `w`rap
nmapkey('<leader>w', 'viw')

-- ========= Faster buffer navigation ========
-- `N`ext buffer
nmapkey('<leader>N', ':bn<CR>')

-- `P`revious buffer
nmapkey('<leader>P', ':bp<CR>')

-- `D`elete buffer
nmapkey('<leader>D', ':bd<CR>')

-- ======== DAP ======== 

-- `b`reakpoint: Toggle a breakpoint at the current line
nmapkey('<leader>b', ':lua require("dap").toggle_breakpoint()<CR>')

-- `c`ontinue: Continue execution until the next breakpoint
nmapkey('<leader>c', ':lua require("dap").continue()<CR>')

-- `t`erminate: Terminate the DAP session
nmapkey('<leader>t', ':lua _G.Dapui_terminate()<CR>')

-- `i`n: Step into a function or line of code
nmapkey('<leader>i', ':lua require("dap").step_into()<CR>')

-- `o`ver: Step over the current line (skip function calls)
nmapkey('<leader>o', ':lua require("dap").step_over()<CR>')

-- `f`inish: Step out of the current function
nmapkey('<leader>f', ':lua require("dap").step_out()<CR>')

-- `C`lear `B`reakpoints: Clear all breakpoints in the current session
nmapkey('<leader>CB', ':lua require("dap").clear_breakpoints()<CR>')

-- `r`eset and open the DAP UI
nmapkey('<Leader>r', ':lua require("dapui").open({reset = true})<CR>')

-- Set conditional `B`reakpoint: Set a breakpoint with a user-defined condition
nmapkey('<leader>B', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition (key==\'value\'): "))<CR>')
