set nocompatible

let vimfiles = $HOME . "/.vim"
let sep = ":"
set guicursor+=a:blinkon0

"filetype off
call pathogen#infect()

set foldmethod=indent
set foldlevel=99

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <leader>td <Plug>TaskList

map <leader>g :GundoToggle<CR>

filetype plugin indent on

set completeopt=menuone,longest,preview

set ai
set lbr " satirlari harflerle degil kelimelerle boler
set encoding=utf-8
set wildmenu
set wildmode=list:longest,full

set backspace=indent,eol,start
syntax on

" searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set smartcase
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.hi,*.cmt,*.cmo,*.cmti

set shiftwidth=4
set scrolloff=5               " keep at least 5 lines above/below

set cul

syntax enable
set grepprg=grep\ -nH\ $*

set autoindent
set expandtab
set smarttab

nnoremap Y y$

" Status line
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

" Backups
set backupdir=~/.vimbackup/backup// " backups
set directory=~/.vimbackup/swap//   " swap files
set backup                        " enable backups

" Enable mouse support in console
set mouse=a

" Clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

let g:molokai_original = 1

if has("gui_running")
    set background=dark
    colorscheme molokai
    " Remove Toolbar
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=l
    set guioptions-=r
    set guifont=Droid\ Sans\ Mono\ 8
    set columns=100
    set lines=50
else
    colorscheme molokai
endif

nnoremap j gj
nnoremap k gk

nnoremap <silent> <C-n> :tabprevious<CR>
nnoremap <silent> <C-m> :tabnext<CR>

nnoremap <silent> <C-f> :noh<CR>


" select all
nnoremap <silent> <C-A> ggVG

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

set clipboard=unnamed

cmap >fd <c-r>=expand('%:p:h').'/'<cr>

map <F1> <Nop>
imap <F1> <Nop>

" indent with spacebar
noremap <space> >>

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
autocmd BufNewFile,BufRead *.json set ft=javascript

let g:Powerline_symbols = 'fancy'

" undo every word
"inoremap <space> <space><C-g>u

nnoremap { {zz
nnoremap } }zz
set noswapfile

set laststatus=2
"set timeoutlen=0
set ttimeoutlen=0

hi! link FoldColumn Normal 
set foldcolumn=3 
set nofoldenable

au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
