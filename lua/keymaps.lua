-- Helper function to make the file a little less verbose
local function mapkey(mode, key, cmd)
    vim.api.nvim_set_keymap(mode, key, cmd, {noremap = true, silent = true})
end

-- Normal mode
local function nmapkey(key, cmd)
    mapkey('n', key, cmd, {noremap = true, silent = true})
end

-- ======== Flash ========

-- Flash jump
mapkey('n', 'ss', '<cmd>lua require("flash").jump()<CR>')
mapkey('x', 'ss', '<cmd>lua require("flash").jump()<CR>')
mapkey('o', 'ss', '<cmd>lua require("flash").jump()<CR>')

-- leader+F to auto-apply formatter/linter
nmapkey('<leader>F', '<cmd>lua vim.lsp.buf.format()<CR>')

-- Ctrl+q to toggle Neo-tree
nmapkey('<C-q>', ':Neotree toggle<CR>')

-- ======== LSP ========

-- Diagnostics are prefixed with 'd'
nmapkey('<leader>gdn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
nmapkey('<leader>gdp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
nmapkey('<leader>dK', '<cmd>lua vim.diagnostic.open_float()<CR>')

-- Hover
nmapkey('K', '<cmd>lua vim.lsp.buf.hover()<CR>')

-- Code actions
nmapkey('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

-- Refactor name
vim.keymap.set("n", "<leader>cr",
               function() return ":IncRename " .. vim.fn.expand("<cword>") end,
               {expr = true, noremap = true, silent = true})

-- Go to Definition
nmapkey('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')

-- Go to Implementation
nmapkey('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

-- Go to References (Uses)
nmapkey('gr', '<cmd>lua vim.lsp.buf.references()<CR>')

-- ======== Surround ========

-- Select word quickly
nmapkey('<leader>w', 'viw')

-- Auto-align file
nmapkey('<leader>A', 'ggVG=')

-- ========= Faster buffer navigation ========
-- Go to the next buffer
nmapkey('<leader>N', ':bn<CR>')

-- Go to the previous buffer
nmapkey('<leader>P', ':bp<CR>')

-- Delete the current buffer
nmapkey('<leader>D', ':bd<CR>')

-- ======== DAP ======== 
-- TODO: refactor to use local functions
nmapkey('<leader>b', ':lua require("dap").toggle_breakpoint()<CR>')
nmapkey('<leader>c', ':lua require("dap").continue()<CR>')
nmapkey('<leader>t', ':lua _G.Dapui_terminate()<CR>')
nmapkey('<leader>i', ':lua require("dap").step_into()<CR>')
nmapkey('<leader>o', ':lua require("dap").step_over()<CR>')
nmapkey('<leader>f', ':lua require("dap").step_out()<CR>')
nmapkey('<leader>CB', ':lua require("dap").clear_breakpoints()<CR>')
nmapkey('<Leader>r', ':lua require("dapui").open({reset = true})<CR>')
nmapkey('<leader>B', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition (key==\'value\'): "))<CR>')
nmapkey('<leader>db', ':DapNvimDebugee<CR>')
nmapkey('<leader>ds', ':DapNvimSource<CR>')

