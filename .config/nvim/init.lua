vim.cmd[[
set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc
]]

-- empty setup using defaults
require("nvim-tree").setup()

