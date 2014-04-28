set nocompatible
let mapleader=','

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
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o,*.hi,*.cmt,*.cmo,*.cmti,*.cmi,*.cmo,*.dvi,*.cmi
let NERDTreeIgnore = ['\.swp$','\.bak$','\.pyc$','\.class$','\.o$','\.hi$','\.cmt$','\.cmo$','\.cmti$','\.cmi$','\.cmo$', '\.dvi$', '\.cmi$']

set backspace=indent,eol,start

" searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
" override `ignorecase` if pattern contains uppercase
set smartcase
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket

set diffopt=filler,iwhite     " ignore all whitespace and sync

set shiftwidth=2
set tabstop=4
set scrolloff=5               " keep at least 5 lines above/below
"set cursorline

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
set completeopt=menuone,longest

" }}}

" {{{ mappings

nnoremap <leader>ev :split  $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" wrap selected text in visual mode with double quotes
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>

noremap H ^
noremap L $

inoremap jk <esc>
inoremap kj <esc>

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

nnoremap Y y$

" Clean whitespace
noremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" convert tabs to 4 space
noremap <leader>T :%s/\t/    /g<CR>

nnoremap j gj
nnoremap k gk

nnoremap <silent> <C-f> :noh<CR>

" select all
nnoremap <silent> <C-A> ggVG

cmap >fd <c-r>=expand('%:p:h').'/'<cr>
nmap <C-N> :e >fd
nmap <C-s> :w<cr>

map <F1> <Nop>
imap <F1> <Nop>

" undo every word
"inoremap <space> <space><C-g>u

" plugins
map <leader>g :GundoToggle<CR>
nmap <leader>n :NERDTreeToggle<CR>

" close preview windows
nnoremap <C-q> <C-w><C-z>

nnoremap <CR> o<ESC>
nnoremap <Space> O<ESC>

" copy all of the buffer to system clipboard
"nnoremap <C-y> mrggVG"+y`r

" start CtrlP with buffer mode
nnoremap <C-b> :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlPTag<CR>
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|cabal-sandbox)$'

nnoremap <PageUp> :bp<CR>
nnoremap <PageDown> :bn<CR>

" search word under the cursor ack plugin
nnoremap <leader>h :exec 'Ack -w --'.&filetype shellescape(expand('<cword>'))<CR>
" shortcut for ack
nnoremap <leader>a :exec 'Ack -w --'.&filetype . ' ' .input("Search term: ")<CR>


" disable shift+k
nnoremap <S-k> <Nop>

" }}}

filetype plugin indent on

let g:molokai_original = 1
autocmd Colorscheme * highlight FoldColumn guifg=bg guibg=bg
autocmd Colorscheme * highlight clear SignColumn
if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions-=L
    set guioptions-=l
    set guioptions-=r
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
    set linespace=0
    set columns=100
    set lines=50
    colorscheme Tomorrow-Night-Eighties
else
    colorscheme Tomorrow-Night
endif
let g:Powerline_symbols = 'fancy'

" {{{ Filetype specific settings

au FileType markdown set spell

au BufNewFile,BufRead *.json set ft=javascript

au! BufRead,BufNewFile *.ll     set filetype=llvm
au! BufRead,BufNewFile *.td     set filetype=tablegen
au! BufRead,BufNewFile *.hsc    set filetype=haskell
au! BufRead,BufNewFile *.pl     set filetype=prolog
au! BufRead,BufNewFile *.dasc   set filetype=c
au! BufRead,BufNewFile *.hs     set shiftwidth=2
au! BufRead,BufNewFile *.hsc    set shiftwidth=2
au! BufRead,BufNewFile *.ml     set shiftwidth=2
au! BufRead,BufNewFile *.mll    set shiftwidth=2
au! BufRead,BufNewFile *.mly    set shiftwidth=2

au BufRead,BufNewFile *.coffee   nnoremap <F4> :!cake build:parser<CR> | nnoremap <F5> :!cake build:game<CR> | nnoremap <F6> :CoffeeCompile<CR> | nnoremap <F3> :!cake build:all<CR>
au FileType coffee set shiftwidth=4
au BufNewFile,BufReadPost *.coffee setl shiftwidth=4 expandtab

au FileType rust set shiftwidth=4
au FileType tex set textwidth=80

au! BufRead,BufNewFile *.lua       nnoremap <F5> :!love ./<CR>
au! BufRead,BufNewFile *.kl        set ft=lisp

hi link coffeeSpaceError NONE

" }}}

" {{{ Plugin specific settings

let g:UltiSnipsNoPythonWarning = 0

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
let g:haskell_tabular       = 0
let g:hpaste_author         = 'osa1'

au FileType haskell nnoremap <leader>sh             :%!stylish-haskell<CR>
au! BufRead,BufNewFile *.lhs set ft=haskell

au FileType asm set noexpandtab
au FileType asm set shiftwidth=4

let g:ctrlp_match_window = 'results:100'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 0

au VimEnter * if filereadable('./Session.vim') | so Session.vim | endif

"au FileType coq CoqLaunch
"au FileType coq call coquille#FNMapping()
"let g:coquille_auto_move = 'true'
let g:CoqIDEDefaultMap = 1
au! BufRead,BufNewFile *.v set filetype=coq

au! BufRead,BufNewFile *.k set filetype=kframework

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#checks = []

" Use Ack.vim with ag instead of ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" }}}
