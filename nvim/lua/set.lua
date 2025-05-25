-- show matching
vim.o.showmatch = true
-- case insensitive
vim.o.ignorecase = true
-- middle-click paste with
vim.o.mouse = 'v'
-- highlight search
vim.o.hlsearch = true
-- incremental search
vim.o.incsearch = true
-- number of columns occupied by a tab
vim.o.tabstop = 2
-- see multiple spaces as tabstops so <BS> does the right thing
vim.o.softtabstop = 2
-- converts tabs to white space
vim.o.expandtab = true
-- width for autoindents
vim.o.shiftwidth = 2
-- indent a new line the same amount as the line just typed
vim.o.autoindent = true
-- add line numbers
vim.o.number = true
-- set relative number
vim.o.relativenumber = true
-- get bash-like tab completions
-- vim.o.wildmenu = true
vim.o.wildmode = 'longest:full,full'
-- set an 80 column border for good coding style
vim.o.colorcolumn = '80'
-- allow auto-indenting depending on file type
vim.cmd('filetype plugin indent on')
-- syntax highlighting
vim.cmd('syntax on')
-- enable mouse click
vim.o.mouse = 'a'
-- using system clipboard
vim.o.clipboard = 'unnamedplus'
-- Ensure filetype is enabled (already done by filetype plugin indent on, but good to be explicit)
vim.cmd('filetype plugin on')
-- highlight current cursorline
vim.o.cursorline = true
-- Speed up scrolling (ttyfast is not a direct equivalent in Neovim; this is often handled by terminal emulators or other settings)
-- If you experience slow scrolling, you might need to look into your terminal emulator's settings or other Neovim configurations.
-- enable spell check (may need to download language package)
-- vim.o.spell = true

-- disable creating swap file
vim.o.swapfile = false
-- Directory to store backup files.
vim.o.backupdir = os.getenv("HOME") ..'/.vim/.cache'

vim.o.smarttab = true       -- Smart handling of tabs in indentation
vim.o.smartindent = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.termguicolors = true
vim.cmd('filetype plugin indent on')

-- My shit
vim.opt.showcmd = true

vim.opt.list = true
vim.opt.listchars = {
    tab = "»·",      -- Show tabs as "»·" (You can customize this)
    -- space = "·",     -- Show spaces as "·"
    trail = "•",     -- Show trailing spaces as "•"
    extends = "›",   -- Show when text extends beyond the screen
    precedes = "‹",  -- Show when there's text before the screen
}
