local opt = vim.opt
local o = vim.o
local g = vim.g

-- Options

o.statusline = ' ◆ %t %m %= %l:%c ◆ '

o.clipboard = 'unnamedplus'
-- o.laststatus = 0
o.wrap = false
o.cursorline = true

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = ' ' }
opt.termguicolors = true
o.ignorecase = true
o.smartcase = true
o.mouse = 'a'

o.number = true
o.numberwidth = 2
o.ruler = false

opt.shortmess:append('sI')

o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = false
o.timeoutlen = 400
o.undofile = true

o.updatetime = 250

-- Globals

g.mapleader = ' '
g.maplocalleader = ','

g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Plugins
require('config.lazy')
require('config.keymaps')
