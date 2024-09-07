-- Use system clipboard
vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'
vim.g.clipboard = {
    name = 'pbcopy/paste',
    copy = {['+'] = 'pbc', ['*'] = 'pbc'},
    paste = {['+'] = 'pbp', ['*'] = 'pbp'},
    cache_enabled = 0
}

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = {
    space = '⋅',
    tab = '→ ',
    trail = '·',
    extends = '❯',
    precedes = '❮',
}

-- Set 4 spaces for indentation instead of tabs
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.shiftwidth = 4         -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4        -- Number of spaces that a <Tab> counts for while editing
vim.opt.tabstop = 4            -- Number of spaces that a <Tab> counts for while editing

-- Enable relative line numbers
vim.opt.number = true          -- Show absolute line numbers
vim.opt.relativenumber = true  -- Show relative line numbers

-- Fully enable mouse support
vim.opt.mouse = 'a'            -- Enable mouse in all modes

-- `,` for leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Display a vertical line at 100 characters
vim.o.colorcolumn = "100"

-- ======== Require ========
require('pkg.lazy')
require('theme.dracula')
require('keymaps')
require('config.lualine')
