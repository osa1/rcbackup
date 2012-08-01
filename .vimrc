set t_Co=256

let vimfiles = $HOME . "/.vim"
let sep = ":"
set guicursor+=a:blinkon0

filetype off
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

"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

:cd ~/

set ai
set ruler
set lbr " satirlari harflerle degil kelimelerle boler
set encoding=utf-8
set wildmenu
set wildmode=list:longest,full

if has("gui_running")
    set columns=90
    set lines=50
endif

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


set title " change the terminal's title

"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Necesary  for lots of cool vim things
set nocompatible

" line numbers
"set number

syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
" insert tabs on the start of a line according to
" shiftwidth, not tabstop
set smarttab

" Make Y not dumb
nnoremap Y y$

" Soft/hard wrapping
" set wrap
" set textwidth=79
" set formatoptions=qrn1
" set colorcolumn=85

" Status line
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

" Backups
set backupdir=~/.vimbackup/backup// " backups
set directory=~/.vimbackup/swap//   " swap files
set backup                        " enable backups

" Enable mouse support in console
set mouse=a

" Ignoring case is a fun trick
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
   "set guifont=Inconsolata\ 11
   "set guifont=Monaco\ 10
else
   colorscheme molokai
endif

if has("gui_running")
    map <F11> :tabedit ~/.vimrc<CR>
    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

nnoremap j gj
nnoremap k gk

" Next Tab
nnoremap <silent> <M-Right> :tabnext<CR>
nnoremap <silent> <C-n> :tabnext<CR>

" Previous Tab
nnoremap <silent> <M-Left> :tabprevious<CR>
nnoremap <silent> <C-p> :tabprevious<CR>
nnoremap <silent> <C-m> :tabnext<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Save with ctrl-s
nnoremap <silent> <C-s> :w<CR>

nnoremap <silent> <C-f> :noh<CR>

set cul


nmap <F6> :!python %<CR>

map <A-1> :tabn 1<CR>
map <A-2> :tabn 2<CR>
map <A-3> :tabn 3<CR>
map <A-4> :tabn 4<CR>
map <A-5> :tabn 5<CR>
map <A-6> :tabn 6<CR>
map <A-7> :tabn 7<CR>
map <A-8> :tabn 8<CR>
map <A-9> :tabn 9<CR>

" select all
nnoremap <silent> <C-A> ggVG

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

set clipboard=unnamed

imap <c-d> <esc>dba
cmap >fd <c-r>=expand('%:p:h').'/'<cr>

if has("gui_running") 
    highlight SpellBad term=underline gui=undercurl guisp=Orange 
endif 

" nnoremap <F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
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

