syntax on
set nocompatible
set noerrorbells                         " no error bells
set shiftwidth=4
set nohlsearch
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir              " set a undo directory 
set undofile
set incsearch
set number relativenumber               " sets relative line number
set nu rnu
set cursorline                          " highliht current line
set cmdheight=1
set ignorecase                          " ignore case while searching
set laststatus=2                        " always show status line
set termguicolors                       " true colors
set clipboard+=unnamedplus              " set clipboard to system clipboard
set path+=**                            " ** for recursive search on all dir
set wildmenu
filetype plugin indent on
filetype plugin on
set ttyfast                             "for faster scrolling
set lazyredraw                          "faster scrolling

" status line
set statusline=
set statusline+=%#DraculaTodo#
set statusline+=\ %M
set statusline+=\ %y
set statusline+=\ %r
set statusline+=\ %F
set statusline+=\ %=                     "rightside
set statusline+=%#DraculaSearch#
set statusline+=\ %c:%l/%L
set statusline+=\ %p%%
set statusline+=\ [%n]

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'scrooloose/nerdtree'
Plug 'ap/vim-css-color'
call plug#end()

colorscheme dracula
hi Normal guibg=none
hi Normal ctermbg=none


let mapleader="SPACE"
inoremap jk <ESC><CR>                   
map <C-s> :source ~/.config/nvim/init.vim<CR>
map <SPACE> : NERDTreeToggle %<CR>
