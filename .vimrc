
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

let g:pep8_map='<leader>8'

"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

:cd ~/

" conque
"let g:ConqueTerm_Color = 0
let g:ConqueTerm_FastMode = 1
function MyConqueStartup(term)
    let syntax_associations = {'ipython': 'python'}
endfunction
call conque_term#register_function('after_startup', 'MyConqueStartup')


" clojure
let classpath = join(
   \[".",
   \ "src", "src/main/clojure", "src/main/resources",
   \ "test", "src/test/clojure", "src/test/resources",
   \ "classes", "target/classes",
   \ "lib/*", "lib/dev/*",
   \ "bin",
   \ vimfiles."/lib/*"
   \],
   \ sep)

let g:vimclojure#DynamicHighlighting = 0
let vimclojureRoot = vimfiles."/bundle/vimclojure"
let vimclojure#HighlightBuiltins = 1
let vimclojure#HighlightContrib = 1
let vimclojure#ParenRainbow  = 1
let vimclojure#WantNailgun   = 1
let vimclojure#NailgunClient = vimfiles."/vimclojure-nailgun-client/ng"


" slimv
let g:slimv_swank_clojure = '! xterm -e lein swank &'
let g:lisp_rainbow = 0
let g:slimv_repl_syntax = 1

" end clojure


" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

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

" NERDTree
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index', 'xapian_index', '.*.pid', '*\.o$', '.*-fixtures-.*.json']

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
   "set guifont=Droid\ Sans\ Mono\ 10
   set guifont=Inconsolata\ 11
else
   colorscheme smyck
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

nnoremap <silent> <F7> :TagbarToggle<CR>
nnoremap <silent> <F8> :NERDTreeToggle<CR>
" select all
nnoremap <silent> <C-A> ggVG

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

set clipboard=unnamed

imap <c-d> <esc>dba
cmap >fd <c-r>=expand('%:p:h').'/'<cr>

if has("gui_running") 
    highlight SpellBad term=underline gui=undercurl guisp=Orange 
endif 

" I changed my keyboard layout so there is no need for them
"map ğ {
"map ü }
"map ğ [
"map ü ]
"map Ğ {
"map Ü }
"imap ğ [
"imap ü ]
"imap Ğ {
"imap Ü }

" nnoremap <F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
map <F1> <Nop>
imap <F1> <Nop>

" indent with spacebar
noremap <space> >>

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="
autocmd BufNewFile,BufRead *.json set ft=javascript

let g:haddock_browser = "/usr/bin/chromium"
let g:Powerline_symbols = 'fancy'

" undo every word
inoremap <space> <space><C-g>u



