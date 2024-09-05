-- TODO refactor all configs to own files
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- ======== Packages go here ========

return require('lazy').setup({
    -- Dracula theme
    {
        'Mofiqul/dracula.nvim'
    },
    -- Flash
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            modes = {
                search = {
                    enabled = false
                }
            }
        }
    },

    -- todo
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    -- neogen
    { 
        "danymat/neogen", 
        config = true,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*" 
    },

    -- lspconfig and mason
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'jay-babu/mason-nvim-dap.nvim'
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup()
            local lspconfig = require('lspconfig')

            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})

        end,
    },

    -- barbar, requires gitsigns
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('gitsigns').setup({
                signcolumn = true,
            })
        end,
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },

    -- treesitter
    -- TODO: move to own config
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
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
        end,
    },

    -- tree
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
            -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function() 
            require('neo-tree').setup({
                enable_git_status = true,
                enable_diagnostics = true,
                close_if_last_window = true,
                with_markers = true,
                indent_marker = '│',
                last_indent_marker = '└',
                highlight = 'NeoTreeIndentMarker',
                window = {
                    position = 'right',
                    width = 60,
                }
            })
        end
    },

    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('config.lualine').setup()
        end,
    },

    -- lazygit
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },

    -- auto-close brackets
    {
        'rstacruz/vim-closer'
    },

    -- surround
    {
        'echasnovski/mini.surround',
        config = function() require('mini.surround').setup() end
    },

    -- Refactor
    {
        'smjonas/inc-rename.nvim',
        -- TODO Is this necessary?
        opts = {}
    },

    -- DAP
    {
        'rcarriga/nvim-dap-ui',
        event = "VeryLazy",
        config = function() require("config.nvim-dap") end,
        dependencies = {
            -- DAP
            'mfussenegger/nvim-dap',
            -- Variable inspection
            'theHamsta/nvim-dap-virtual-text',
            -- Async I/O
            'nvim-neotest/nvim-nio'
        }
    },
})


