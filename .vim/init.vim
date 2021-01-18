set nocompatible
let mapleader=','

" {{{ settings

set t_Co=256

set noruler
set noshowcmd
set nomodeline

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
    \.cabal-sandbox
    \.stack-work
let NERDTreeIgnore =
    \[ '\.swp$',
    \'\.bak$',
    \'\.pyc$',
    \'\.class$',
    \'\.hi$',
    \'\.dyn_o$',
    \'\.dyn_hi$',
    \'\.cmt$',
    \'\.cmo$',
    \'\.cmti$',
    \'\.cmi$',
    \'\.cmo$',
    \'\.dvi$',
    \'\.cmi$',
    \'\.cmx$',
    \'\.o$'
    \]
let NERDTreeShowHidden=1

set backspace=indent,eol,start

" searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set gdefault
set inccommand=nosplit
set smartcase                 " override `ignorecase` if pattern contains uppercase
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow

"set diffopt=filler,iwhite     " ignore all whitespace and sync
" Disabling iwhite, causing problems when commiting stuff using :Gdiff
set diffopt=filler,hiddenoff

set shiftwidth=4
set tabstop=8                 " same as the default
set scrolloff=5               " keep at least 5 lines above/below
set textwidth=0               " set for each filetype
"set cursorline

syntax enable

set autoindent
set expandtab                 " insert spaces instead of tabs
set smarttab

set foldmethod=indent
set foldlevel=99

" set nobackup
" set noswapfile
set backupdir=~/vimtmp//,.
set directory=~/vimtmp//,.

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

" Disable comment syntax, ft plugins set this anyway, and it's annoying when vim
" treats chars as comment when typing plain text.
set comments=""
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
  elseif a:lang == "cfg"
    return "toml"
  elseif a:lang == "d"
    return "dlang"
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

nnoremap <leader>d  :Gdiff<CR>
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

" Jump to previous change
nmap <A-Up> g;
" Jump to next change
nmap <A-Down> g,

" }}}

filetype plugin indent on

autocmd Colorscheme * highlight FoldColumn guifg=bg guibg=bg
autocmd Colorscheme * highlight clear SignColumn
set termguicolors
" let g:molokai_original = 1
" colorscheme molokai
packadd! dracula-vim
colorscheme dracula
hi! link Type DraculaCyan
hi! link Delimiter DraculaComment
hi! link VertSplit DraculaComment
hi! link Function DraculaFg
hi! link rustModPath DraculaFg
hi! link rustCommentLineDoc DraculaCommentBold

let s:theme = 0
function! ToggleTheme()
    if s:theme == 0
        set background=light
        colorscheme NeoSolarized
        let s:theme = 1
    else
        set background=dark
        colorscheme dracula
        let s:theme = 0
    endif
endfunction

map <F11> :call ToggleTheme()<CR>

" {{{ Filetype specific settings

au FileType markdown setlocal spell
" let g:markdown_fenced_languages = ['c', 'lua', 'haskell', 'ocaml', 'rust']

au FileType cpp     setlocal formatoptions+=c
au FileType haskell nnoremap <leader>sh :%!stylish-haskell<CR>
au FileType haskell nnoremap <leader>ft :!fast-tags . -R<CR><CR>
au FileType haskell setlocal shiftwidth=2
au FileType haskell setlocal textwidth=80
au FileType rust    nnoremap <leader>f :RustFmt<CR>
au FileType rust    set foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*'.&commentstring[0] | execute "normal zM"

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
au! BufRead,BufNewFile *.mo     set ft=motoko
au! BufRead,BufNewFile *.gp     set ft=gnuplot

au VimEnter * if filereadable('./Session.vim') | so Session.vim | endif

" }}}

" {{{ Plugin specific settings

"""""""""""
" airline "
"""""""""""

" let g:airline_left_sep=''
" let g:airline_right_sep=''
let g:airline_extensions = ['branch', 'coc']
let g:airline_theme='dracula'
let g:airline_highlighting_cache = 1
let g:airline_powerline_fonts = 1

let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }

" The default with the L/N icon removed: <line number>/<num lines>:<column number>
let g:airline_section_z = "%p%% %#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L%#__restore__#:%v"

let g:haskell_enable_quantification = 1
let g:haskell_enable_typeroles = 1
let g:haskell_indent_if = 2

" Disabled: formatting file causes losing the jump buffer, recent changes etc.
let g:rustfmt_autosave = 0

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

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" }}}

function! MakeDetails()
    let l:startline = line("'<")
    let l:endline = line("'>")

    call inputsave()
    let l:summary = input('Summary: ')
    call inputrestore()

    call append(l:endline, "")
    call append(l:endline+1, "</details>")
    call append(l:startline - 1, "<details>")
    call append(l:startline, "")
    call append(l:startline + 1, "<summary>" . l:summary . "</summary>")
    call append(l:startline + 2, "")
endfunction foo

vnoremap <leader>md :<C-u>call MakeDetails()<CR>

"""""""
" coc "
"""""""

" Reminder: run `:CocInstall coc-rust-analyzer`

nmap <leader>fr     <Plug>(coc-references)
nmap <leader>r      <Plug>(coc-rename)
nmap <leader>ge     :<C-u>CocList diagnostics<CR>
nmap <leader>gp     <Plug>(coc-diagnostic-prev)
nmap <leader>gn     <Plug>(coc-diagnostic-next)
nmap <leader>gd     <Plug>(coc-definition)
xmap <leader>a      <Plug>(coc-codeaction-selected)<CR>
nmap <leader>a      <Plug>(coc-codeaction-selected)<CR>
" I don't understand what does the next one do, but it doesn't seem to work with
" rust-analyzer. Also, need to find another binding for it as it causes lag in
" <leader>a bindings above.
nmap <leader>ac  <Plug>(coc-codeaction)

" List workspace symbols
nmap <leader>ss     :<C-u>CocList -I symbols<CR>
nmap <leader>o      :<C-u>CocList outline<CR>
nmap K              :call CocAction('doHover')<CR>
" Trigger auto-completion with C-space.
imap <expr>         <c-space> coc#refresh()
imap <C-p>          <C-o>:call CocActionAsync('showSignatureHelp')<CR>
