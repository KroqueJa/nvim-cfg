local M = {}

M.setup = function()
    return require('nvim-treesitter.configs').setup({
        ensure_installed = 'all', -- Install parsers for all supported languages
        highlight = {
            enable = true, -- Enable Tree-sitter based syntax highlighting
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
        },
    })
end

return M.setup()
