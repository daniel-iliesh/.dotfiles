" --- Basic Settings ---
set showmatch       " Show matching brackets
set ignorecase      " Case insensitive searching
set hlsearch        " Highlight search results
set incsearch       " Incremental search
set termguicolors   " Enable true colors in the terminal

" --- Tabs and Indentation ---
set tabstop=2       " Number of columns for a tab
set softtabstop=2   " Number of spaces for a tab in editing operations
set expandtab       " Convert tabs to spaces
set shiftwidth=2    " Width for autoindents
set autoindent      " Indent new lines automatically
set smarttab        " Smart handling of tabs
set smartindent     " Smart auto-indenting for C-like languages

" --- UI and Appearance ---
set number          " Add line numbers
set relativenumber  " Use relative line numbers
set wildmode=longest:full,full " Enhanced command-line completion
set colorcolumn=80  " Highlight the 80th column
set cursorline      " Highlight the current line
set showcmd         " Show (partial) command in the last line of the screen
set list            " Show characters for tabs and trailing spaces
set listchars=tab:»·,trail:•,extends:›,precedes:‹ " Characters for list mode

" --- File and System ---
filetype plugin indent on " Enable filetype detection, plugins, and indentation
syntax on                 " Enable syntax highlighting
set mouse=a               " Enable mouse support in all modes
set clipboard=unnamedplus " Use system clipboard for yank/paste
set noswapfile            " Disable creation of swap files
set undofile              " Enable persistent undo
colorscheme retrobox      " Set the colorscheme

" --- Paths and Directories ---
" Set directories for backup and undo files
let &backupdir = $HOME . '/.vim/.cache'
let &undodir = $HOME . '/.vim/undodir'

" --- Plugin Specific (netrw) ---
let g:netrw_keepdir = 0 " Keep netrw in the directory of the edited file
