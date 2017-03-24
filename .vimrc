set nocompatible
let mapleader=','

let vimfiles = $HOME . "/.vim"
call pathogen#infect()

" {{{ settings

set hidden
set guicursor+=a:blinkon0     " disable cursor blinking
set guicursor+=i:block-Cursor " use block cursor in insert mode(for GUIs)
set guicursor+=i:blinkon0     " don't blink in insert mode too

set linebreak                 " wraplong lines at a character in `breakat`
set encoding=utf-8

set wildmenu
set wildmode=list:longest,full
set wildignore=
    \*.swp,
    \*.bak,
    \*.pyc,
    \*.class,
    \*.o,
    \*.hi,
    \*.dyn_o,
    \*.dyn_hi,
    \*.cmt,
    \*.cmo,
    \*.cmti,
    \*.cmi,
    \*.cmo,
    \*.dvi,
    \*.cmi,
    \dist/,
    \.cabal-sandbox
let NERDTreeIgnore =
    \[ '\.swp$',
    \'\.bak$',
    \'\.pyc$',
    \'\.class$',
    \'\.o$',
    \'\.hi$',
    \'\.dyn_o$',
    \'\.dyn_hi$',
    \'\.cmt$',
    \'\.cmo$',
    \'\.cmti$',
    \'\.cmi$',
    \'\.cmo$',
    \'\.dvi$',
    \'\.cmi$'
    \]

set backspace=indent,eol,start

" searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
" override `ignorecase` if pattern contains uppercase
set smartcase
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket

"set diffopt=filler,iwhite     " ignore all whitespace and sync
" Disabling iwhite, causing problems when commiting stuff using :Gdiff
set diffopt=filler

set shiftwidth=4
set tabstop=4
set scrolloff=5               " keep at least 5 lines above/below
"set cursorline

syntax enable

set autoindent
set expandtab                 " insert spaces instead of tabs
set smarttab

set foldmethod=manual
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

set formatoptions+=croqjl

au BufEnter * syntax sync minlines=1000000

set lazyredraw
set nojoinspaces
" }}}

" {{{ mappings

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
map <leader>gu :GundoToggle<CR>
nmap <leader>n :NERDTreeToggle<CR>

" resizing splits
nnoremap <C-Up> <C-w>+
nnoremap <C-Down> <C-w>-
nnoremap <C-Left> <C-w>-
nnoremap <C-Left> <C-w><
nnoremap <C-Right> <C-w>>

nnoremap <CR> o<ESC>
nnoremap <Space> O<ESC>

" copy all of the buffer to system clipboard
"nnoremap <C-y> mrggVG"+y`r

" start CtrlP with buffer mode
nnoremap <C-b> :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlPTag<CR>
" NB: I shouldn't be using this for two reasons:
"     - CtrlP is using wildignore already.
"     - If g:ctrlp_user_command is defined, then this is not used at all.
" So I'm making relevant changes in g:ctrp_user_command instead.
"let g:ctrlp_custom_ignore = '[\/]\.(git|hg|svn|cabal-sandbox)$'

nnoremap <PageUp> :bp<CR>
nnoremap <PageDown> :bn<CR>

" search word under the cursor ack plugin
function! Fixc(lang)
  if a:lang == "c"
    return "cc"
  elseif a:lang == "javascript"
    return "js"
  else
    return a:lang
  endif
endfunction
nnoremap <leader>h :exec 'Ack! -w --'.Fixc(&filetype) shellescape(expand('<cword>'))<CR>
nnoremap <leader>w :Ack! -w --<c-r>=Fixc(&filetype) . ' '<cr>

" disable shift+k
nnoremap <S-k> <Nop>

" remove an annoying binding
nnoremap `S <Nop>
vnoremap <S-k> k

" disable worst feature ever
map Q <Nop>

" toggle spell
nnoremap <leader>sp :setlocal spell!<cr>

" sort a paragraph, case insensitive. leaves the cursor at the original
" position.
" (using register m because I couldn't find a better way)
nnoremap <leader>ss mmvip:sort i<cr>`m

" because vim is a pre-historic software with stupid features
noremap <F12> <Esc>:syntax sync fromstart<CR>

nnoremap <leader>gg :!gitg &<CR><CR>

" search in selection
vnoremap <leader>/ <Esc>/\%V

vnoremap <C-c> "+y

nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>dc :Git! diff --cached<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>

" Experimental - I realized I never use ?, but I use "word search" all the
" time.
nnoremap ? /\<\><Left><Left>

" Turkish deasciifier
nnoremap <leader>da :%!turkish-deasciifier<CR>
vnoremap <leader>da <esc>:'<,'>:!turkish-deasciifier<CR>

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
    set guifont=xos4\ Terminess\ Powerline\ 10
    set guioptions+=c
    set linespace=0
    set columns=100
    set lines=50
    colorscheme molokai
elseif has("nvim")
    set termguicolors
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
    colorscheme molokai
else
    colorscheme Tomorrow-Night
endif

" {{{ Filetype specific settings

au FileType markdown setlocal spell
let g:markdown_fenced_languages = ['c', 'lua', 'haskell', 'ocaml', 'rust']

au FileType cpp     set formatoptions+=c
au FileType haskell nnoremap <leader>sh :%!stylish-haskell<CR>
au FileType haskell nnoremap <leader>ft :!fast-tags . -R<CR><CR>
au FileType haskell set shiftwidth=2
au FileType haskell set textwidth=80

au! BufRead,BufNewFile *.dasc   set ft=c
au! BufRead,BufNewFile *.fun    set ft=sml
au! BufRead,BufNewFile *.hsc    set ft=haskell
au! BufRead,BufNewFile *.json   set ft=javascript
au! BufRead,BufNewFile *.lhs    set ft=haskell
au! BufRead,BufNewFile *.ll     set ft=llvm
au! BufRead,BufNewFile *.md     set ft=markdown
au! BufRead,BufNewFile *.pl     set ft=prolog
au! BufRead,BufNewFile *.sig    set ft=sml
au! BufRead,BufNewFile *.sml    set ft=sml
au! BufRead,BufNewFile *.td     set ft=tablegen
au! BufRead,BufNewFile *.v      set ft=coq
au! BufRead,BufNewFile *.x      set ft=text " alex
au! BufRead,BufNewFile *.y      set ft=text " happy

au VimEnter * if filereadable('./Session.vim') | so Session.vim | endif

" }}}

" {{{ Plugin specific settings

let g:ctrlp_match_window = 'results:100'
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .o
      \ --ignore .hi
      \ --ignore .cabal
      \ --ignore dist
      \ --ignore .cabal-sandbox
      \ -g ""'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

"au FileType coq CoqLaunch
"au FileType coq call coquille#FNMapping()
"let g:coquille_auto_move = 'true'
let g:CoqIDEDefaultMap = 1

" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_extensions = ['ctrlp', 'branch']

" Use Ack.vim with ag instead of ack
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

let g:ackhighlight = 1

let g:haskell_enable_quantification = 1
let g:haskell_enable_typeroles = 1
let g:haskell_indent_if = 2

" }}}

function! AdjustFontSize(amount)
  let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
  let s:minfontsize = 6
  let s:maxfontsize = 16
  if has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()
