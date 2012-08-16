let vimfiles = $HOME . "/.vim"
let sep = ":"
set guicursor+=a:blinkon0

"filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
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

:cd ~/

set ai
set ruler
set lbr " satirlari harflerle degil kelimelerle boler
set encoding=utf-8
set wildmenu
set wildmode=list:longest,full

set backspace=indent,eol,start
syntax on

" searching
set incsearch                 " incremental search
"set ignorecase                " search ignoring case
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o

set tabstop=4
set shiftwidth=4
set scrolloff=5               " keep at least 5 lines above/below

" Necesary  for lots of cool vim things
set nocompatible

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

set ignorecase
set smartcase

" Clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

if has("gui_running")
  set background=dark
  colorscheme mustang
  " Remove Toolbar
  set guioptions-=T
  set guioptions-=m
  set guioptions-=L
  set guioptions-=l
  set guioptions-=r
  set guifont=Droid\ Sans\ Mono\ 8
else
   colorscheme molokai
endif

nnoremap j gj
nnoremap k gk

nnoremap <silent> <C-n> :tabnext<CR>
nnoremap <silent> <C-m> :tabnext<CR>

nnoremap <silent> <C-f> :noh<CR>

set cul

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
