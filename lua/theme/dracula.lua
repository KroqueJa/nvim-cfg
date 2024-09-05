vim.cmd[[colorscheme dracula-soft]]

local dracula_colors = require('dracula').colors()
-- Override paren matching color
vim.cmd([[
  highlight MatchParen guifg=NONE guibg=]] .. dracula_colors.selection .. [[ gui=NONE
]])

