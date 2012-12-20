set nocompatible

if !has("gui_running")
    set term=screen-256color
endif

let vimfiles = $HOME . "/.vim"
call pathogen#infect()

" {{{ settings
set hidden
set guicursor+=a:blinkon0     " disable cursur blinking
set linebreak                 " wraplong lines at a character in `breakat`
set encoding=utf-8

set wildmenu
set wildmode=list:longest,full
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.hi,*.cmt,*.cmo,*.cmti

set backspace=indent,eol,start

" searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
" override `ignorecase` if pattern contains uppercase
set smartcase
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket

set diffopt=filler,iwhite     " ignore all whitespace and sync

set shiftwidth=4
set scrolloff=5               " keep at least 5 lines above/below
set cursorline

syntax enable

set autoindent
set expandtab                 " insert spaces instead of tabs
set smarttab

set foldmethod=marker
set foldlevel=99

" Status line
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

set nobackup
set noswapfile

" Enable mouse support in console
set mouse=a

" don't save this info when :mksession
set ssop-=blank " empty windows
set ssop-=folds

set showbreak=↪

set laststatus=2             " always show status line

"set timeoutlen=0
set ttimeoutlen=0

set nofoldenable             " open all folds
set foldcolumn=3             " left margin

" insert mode completion options
set completeopt=menuone,longest,preview
" }}}

" {{{ mappings
nnoremap <leader>ev :split  $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" wrap selected text in visual mode with double quotes
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>

nnoremap H ^
nnoremap L $

" experimental
inoremap jk <esc>
inoremap <esc> <nop>

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

nnoremap Y y$

" Clean whitespace
noremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap j gj
nnoremap k gk

nnoremap <silent> <C-n> :tabprevious<CR>
nnoremap <silent> <C-m> :tabnext<CR>

nnoremap <silent> <C-f> :noh<CR>

" select all
nnoremap <silent> <C-A> ggVG

cmap >fd <c-r>=expand('%:p:h').'/'<cr>

map <F1> <Nop>
imap <F1> <Nop>

" undo every word
"inoremap <space> <space><C-g>u

" plugins
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
nmap <C-t> :NERDTreeToggle<CR>

nnoremap <leader>l :hi! link FoldColumn Normal<CR>
" }}}

filetype plugin indent on

colorscheme Tomorrow-Night
hi! link FoldColumn Normal
if has("gui_running")
    set background=dark
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=l
    set guioptions-=r
    set guifont=Source\ Code\ Pro\ for\ Powerline\ Semibold\ 8
    set columns=100
    set lines=50
endif

let g:Powerline_symbols = 'fancy'

" Filetype specific settings
au FileType haskell nnoremap <buffer> <F1> :GhcModType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :GhcModTypeClear<CR>

au FileType markdown set spell

au BufNewFile,BufRead *.json set ft=javascript

au! BufRead,BufNewFile *.ll     set filetype=llvm
au! BufRead,BufNewFile *.td     set filetype=tablegen

let g:haskell_conceal       = 0
let g:haskell_quasi         = 0
let g:haskell_interpolation = 0
let g:haskell_regex         = 0
let g:haskell_jmacro        = 0
let g:haskell_shqq          = 0
let g:haskell_sql           = 0
let g:haskell_json          = 0
let g:haskell_xml           = 0
let g:haskell_hsp           = 0
