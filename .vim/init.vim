set nocompatible
let mapleader=','

" {{{ settings

set t_Co=256

set noruler
set noshowcmd

set hidden
set guicursor=
"set guicursor+=a:blinkon0     " disable cursor blinking
"set guicursor+=i:block-Cursor " use block cursor in insert mode(for GUIs)
"set guicursor+=i:blinkon0     " don't blink in insert mode too
set fillchars=vert:\|

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
    \dist-newstyle/,
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
    \'dist',
    \'dist-newstyle',
    \'target',
    \]

set backspace=indent,eol,start

" searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set gdefault
set inccommand=nosplit
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
set textwidth=80
"set cursorline

syntax enable

set autoindent
set expandtab                 " insert spaces instead of tabs
set smarttab

set foldmethod=indent
set foldlevel=99

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
" Make it work in insert mode too. NOTE TO SELF: Disabled. It turns out I hit
" these keys accidentally a lot.
" inoremap <c-h> <c-o>0
" inoremap <c-l> <c-o>$

inoremap jk <esc>
inoremap kj <esc>

" c-e/c-y should work the same in insert and normal modes
inoremap <c-e> <c-o><c-e>
inoremap <c-y> <c-o><c-y>

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
nnoremap <leader>sb :bufdo! set noscrollbind<CR>

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
nnoremap <C-Left> <C-w><
nnoremap <C-Right> <C-w>>

nnoremap <CR> o<ESC>
nnoremap <Space> O<ESC>

nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
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
nnoremap <leader>j :exec 'Ag ' . shellescape(expand('<cword>'))<CR>
nnoremap <leader>w :Ag -w --<c-r>=Fixc(&filetype) . ' '<cr>
nnoremap <leader>e :Ag

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
" vnoremap <leader>/ <Esc>/\%V
" I use this feature more than I use the actual behavior of / in select visual
" mode, so:
vnoremap / <Esc>/\%V
" Substutite in selection. C-s in normal mode saves. TODO: Maybe save
" automatically and do substitution in normal mode too, would be more
" consistent, less stuff to remember.
" (remember that '<,'> part is inserted automaticall on : in visual mode)
vmap <C-s> :s/

vnoremap <C-c> "+y
inoremap <C-v> <C-o>:set paste<CR><C-r>+<C-o>:set nopaste<CR>

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

" Show highlighting group used for the thing under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Reload buffers when files change between FocusLost/FocusGained
au FocusGained * checktime

" Fold the whole file. Reminder: zR opens all folds.
nmap Zc <C-a>zc
nmap ZC <C-a>zC

" }}}

filetype plugin indent on

autocmd Colorscheme * highlight FoldColumn guifg=bg guibg=bg
autocmd Colorscheme * highlight clear SignColumn
set termguicolors
" let g:molokai_original = 1
" colorscheme molokai
colorscheme dracula
hi! link Type DraculaCyan
hi! link Delimiter DraculaComment
hi! link VertSplit DraculaComment
hi! link Function DraculaFg
hi! link rustModPath DraculaFg

" {{{ Filetype specific settings

au FileType markdown setlocal spell
let g:markdown_fenced_languages = ['c', 'lua', 'haskell', 'ocaml', 'rust']

au FileType cpp     setlocal formatoptions+=c
au FileType haskell nnoremap <leader>sh :%!stylish-haskell<CR>
au FileType haskell nnoremap <leader>ft :!fast-tags . -R<CR><CR>
au FileType haskell setlocal shiftwidth=2
au FileType haskell setlocal textwidth=80


""""""""""""""""""
" Quickfix stuff "
""""""""""""""""""

" Restore <CR> behavior
au FileType qf silent! nnoremap <buffer> <CR> <CR>
" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.')
  let qfall = getqflist()
  call remove(qfall, curqfidx-1)
  call setqflist(qfall, 'r')
  execute "normal " . curqfidx . "gg"
endfunction
au FileType qf map <buffer> dd :call RemoveQFItem()<cr>

""""""""""""""""""

au! BufRead,BufNewFile *.hsc    set ft=haskell
au! BufRead,BufNewFile *.json   set ft=javascript
au! BufRead,BufNewFile *.md     set ft=markdown
au! BufRead,BufNewFile *.x      set ft=text   " alex
au! BufRead,BufNewFile *.y      set ft=text   " happy
au! BufRead,BufNewFile *.t      set ft=python " GHC's test files
au! BufRead,BufNewFile *.h      set ft=c
au! BufRead,BufNewFile .envrc   set ft=sh

au VimEnter * if filereadable('./Session.vim') | so Session.vim | endif

" }}}

" {{{ Plugin specific settings

"""""""""""
" airline "
"""""""""""

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_extensions = ['branch', 'tagbar']
let g:airline_theme='dracula'
let g:airline_highlighting_cache = 1

let g:haskell_enable_quantification = 1
let g:haskell_enable_typeroles = 1
let g:haskell_indent_if = 2

 let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \]
    \}

"""""""
" FZF "
"""""""

function! s:fzf_statusline()
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

command! -nargs=+ Ag call fzf#vim#ag_raw(<q-args>)

"""""""""""""
" gitgutter "
"""""""""""""

" Disable by default
let g:gitgutter_enabled = 0
" Disable realtime updates
autocmd BufWritePost * GitGutter
" Toggle binding
map <leader>gg :GitGutterToggle<CR>

" }}}
