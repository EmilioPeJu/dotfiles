local g = vim.g
local opt = vim.opt
opt.clipboard = 'unnamedplus'
opt.backupdir = vim.fn.stdpath('data') .. '/backup'
opt.smartcase = true
opt.shell = 'bash'
opt.hidden = true
opt.tags = './tags'

-- Appearance
opt.background = 'dark'
opt.autoindent = true
opt.copyindent = true
opt.ruler = true
opt.number = true
opt.showbreak = '···'
opt.listchars = {
    tab = '»¯',
    trail = '°',
    extends = '»',
    precedes = '«'
}
opt.list = true;
opt.colorcolumn = '80'
opt.wrap = true
vim.cmd('colorscheme wal')
opt.termguicolors = true;

-- Tab settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.textwidth = 80
opt.autoindent = true

-- Folding
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99

-- Search
opt.ignorecase = true
