set nocompatible
let mapleader=','

let vimfiles = $HOME . "/.vim"
call pathogen#infect()

" {{{ settings

set hidden
set guicursor=
"set guicursor+=a:blinkon0     " disable cursor blinking
"set guicursor+=i:block-Cursor " use block cursor in insert mode(for GUIs)
"set guicursor+=i:blinkon0     " don't blink in insert mode too

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
    \.stack-work
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
map <leader>gu :MundoToggle<CR>
nmap <leader>n :NERDTreeToggle<CR>

" resizing splits
nnoremap <C-Up> <C-w>+
nnoremap <C-Down> <C-w>-
nnoremap <C-Left> <C-w>-
nnoremap <C-Left> <C-w><
nnoremap <C-Right> <C-w>>

nnoremap <CR> o<ESC>
nnoremap <Space> O<ESC>

nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-l> :Lines<CR>
nnoremap <leader>t :Tags<CR>

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
nnoremap <leader>h :exec 'Ag -w --'.Fixc(&filetype) shellescape(expand('<cword>'))<CR>
nnoremap <leader>w :Ag -w --<c-r>=Fixc(&filetype) . ' '<cr>

" disable shift+k
nnoremap <S-k> <Nop>

" remove an annoying binding
nnoremap `S <Nop>
vnoremap <S-k> k

" disable worst feature ever
map Q <Nop>

" toggle spell
nnoremap <leader>sp :setlocal spell!<cr>

" because vim is a pre-historic software with stupid features
noremap <F12> <Esc>:syntax sync fromstart<CR>

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

" Reload buffers when files change between FocusLost/FocusGained
au FocusGained * checktime

" }}}

filetype plugin indent on

let g:molokai_original = 1
autocmd Colorscheme * highlight FoldColumn guifg=bg guibg=bg
autocmd Colorscheme * highlight clear SignColumn
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
colorscheme molokai

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

" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_extensions = ['branch']

let g:haskell_enable_quantification = 1
let g:haskell_enable_typeroles = 1
let g:haskell_indent_if = 2


"""""""
" FZF "
"""""""

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

command! -nargs=+ Ag call fzf#vim#ag_raw(<q-args>)

" }}}
